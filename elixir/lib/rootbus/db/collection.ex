defmodule Rootbus.Db.Collection do
  @moduledoc """
  Domain context for accessing and working with __MODULE__ in the system.
  """
  use Rootbus.Context

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @type ecto_p_result :: {:ok | :error, Ecto.Changeset.t()}
      @type model_p_result :: {:ok, @model.t()}
      @model Keyword.get(opts, :model)

      ##########################################################################
      @spec all!(Keyword.t()) :: [@model.t()]
      def all!(clauses) do
        Repo.all(from(t in @model, where: ^clauses))
      end

      def all!(), do: all!([])
      def all(), do: all([])

      # TBD: what is the type captured by `error` Ecto.QueryError when rescued - BJG
      @spec all(Keyword.t()) :: {:error, map} | {:ok, [@model.t()]}
      def all(clauses) do
        {:ok, Repo.all(from(t in @model, where: ^clauses))}
      rescue
        error ->
          {:error, error}
      end

      def all(clauses, %{limit: limit}) do
        {:ok, Repo.all(from(t in @model, where: ^clauses, limit: ^limit))}
      rescue
        error ->
          {:error, error}
      end

      ##########################################################################
      def stream_all!(clauses, func) do
        stream = Repo.stream(from(t in @model, where: ^clauses))

        Repo.transaction(fn ->
          stream
          |> Stream.each(func)
          |> Stream.run()
        end)
      end

      ##########################################################################
      # for raw external use
      def repo_insert(changeset), do: Repo.insert(changeset)

      @spec create(map) :: model_p_result | ecto_p_result
      def create(attrs \\ %{}) do
        attrs
        |> @model.build()
        |> Repo.insert()
      end

      ##########################################################################
      @spec create_if_not_exists(map, Keyword.t()) :: model_p_result | ecto_p_result
      def create_if_not_exists(attrs, clauses) do
        case one(clauses) do
          {:error, reason} ->
            create(attrs)

          {:ok, item} ->
            {:ok, item}
        end
      end

      ##########################################################################
      # for raw external use
      def repo_update(changeset), do: Repo.update(changeset)

      @spec update(@model.t, map) :: model_p_result | ecto_p_result
      def update(%@model{} = item, attrs) when is_map(attrs) do
        item
        |> @model.changeset(attrs)
        |> Repo.update()
      end

      ##########################################################################
      def update_all(clauses, set) do
        from(@model, where: ^clauses)
        |> Repo.update_all(set)
      end

      ##########################################################################
      @spec replace(map, Keyword.t()) :: model_p_result | ecto_p_result
      def replace(attrs, clauses) do
        case one(clauses) do
          {:error, _} ->
            create(attrs)

          {:ok, item} ->
            update(item, attrs)
        end
      end

      # on update DELETE the original item, to get cascading cleanup of related
      # tables.  Can be dangerous if you aren't aware of the impact
      @spec drop_replace(map, Keyword.t()) :: model_p_result | ecto_p_result
      def drop_replace(attrs, clauses) do
        case one(clauses) do
          {:error, _} ->
            create(attrs)

          {:ok, item} ->
            with {:ok, _} <- delete(item) do
              create(attrs)
            end
        end
      end

      @spec upsert(map) :: model_p_result | ecto_p_result
      def upsert(attrs, on_conflict \\ :nothing) do
        attrs
        |> @model.build()
        |> Repo.insert(on_conflict: on_conflict)
      end

      @doc """
      Similar to replace, but it doesn't remove existing values if the attrs has nil
      """
      @spec replace_fill(map, Keyword.t()) :: model_p_result | ecto_p_result
      def replace_fill(attrs, clauses) do
        case one(clauses) do
          {:error, _} ->
            create(attrs)

          {:ok, item} ->
            update_fill(item, attrs)
        end
      end

      @spec update_fill(@model.t, attrs :: map) :: model_p_result | ecto_p_result
      def update_fill(%@model{} = item, attrs) do
        update(item, Utils.Types.remove_nils_from_map(attrs))
      end

      ##########################################################################
      @spec delete(@model.t) :: model_p_result | ecto_p_result
      def delete(%@model{} = item) do
        Repo.delete(item)
      end

      def delete_all(clauses, opts \\ []) do
        Repo.delete_all(from(t in @model, where: ^clauses))
      end

      ##########################################################################
      #      @spec preload!(@model.t, preload :: atom, opts :: Keyword.t) :: @model.t
      #      def preload!(item, preload, opts \\ [])
      #      def preload!(item, preload, opts) when is_atom(preload),
      #        do: preload!(item, [preload], opts)

      @spec preload!(@model.t, preloads :: term(), opts :: Keyword.t()) :: @model.t
      def preload!(item, preloads, opts \\ []) do
        Repo.preload(item, preloads, opts)
      end

      # this might be redundant... preload may not throw an error
      #      @spec preload(@model.t, preload :: atom, opts :: Keyword.t) :: @model.t
      #      def preload(item, preload, opts \\ [])
      #      def preload(item, preload, opts) when is_atom(preload),
      #        do: preload(item, [preload], opts)

      @spec preload(@model.t, preloads :: term(), opts :: Keyword.t()) ::
              model_p_result | ecto_p_result
      def preload(item, preloads, opts \\ []) do
        {:ok, Repo.preload(item, preloads, opts)}
      rescue
        err -> {:error, err}
      end

      ##########################################################################
      def count!() do
        Repo.one(from(p in @model, select: count(p.id)))
      end

      def count!(claims) do
        Repo.one(from(p in @model, where: ^claims, select: count()))
      end

      ##########################################################################
      # use judiciously
      def full_table_scan(clauses, func) do
        stream = Repo.stream(from(p in @model, where: ^clauses))

        Repo.transaction(
          fn ->
            stream
            |> Stream.each(func)
            |> Stream.run()
          end,
          timeout: :infinity
        )
      end

      ##########################################################################
      def associate(%@model{} = item, var, value) do
        item
        |> cast(%{}, [])
        |> put_assoc(var, value)
        |> Repo.update()
        |> case do
          {:ok, record} -> record
          o -> o
        end
      end

      ##########################################################################
      @doc """
      Update our updated_at but only if it hasn't changed within a minute
      (less load)
      """
      @update_min_seconds 60
      def touch(this_id) when is_binary(this_id) do
        with {:ok, this} <- one(id: this_id) do
          touch(this)
        end
      end

      def touch(%{id: this_id, updated_at: updated}) do
        now = Utils.Time.now()

        if now - Timex.to_unix(updated) > @update_min_seconds do
          from(u in @model, where: u.id == ^this_id)
          |> Repo.update_all(set: [updated_at: Timex.now()])
        end
      end

      # Allow for models without timestamps.
      def touch(this), do: this

      ##########################################################################
      # a little workaround hack because I don't want to make id's mutable
      # for everything
      def change_id(%{id: old_id}, new_id) do
        from(u in @model, where: u.id == ^old_id)
        |> Repo.update_all(set: [id: new_id])
      end
    end
  end
end
