defmodule Rootbus.Db.CollectionUuid do
  @moduledoc """
  Domain context for accessing and working with __MODULE__ in the system.
  """
  use Rootbus.Context

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @model Keyword.get(opts, :model)
      @type id :: Ecto.UUID.t()
      use Rootbus.Db.Collection, model: @model

      ##########################################################################
      @spec one!(id | keyword()) :: nil | @model.t()
      def one!(id) when is_binary(id), do: one!([id: id], [])
      def one!(id, preload) when is_binary(id) and is_list(preload), do: one!([id: id], preload)
      def one!(any, preload_atom) when is_atom(preload_atom), do: one!(any, [preload_atom])
      def one!(clauses) when is_list(clauses), do: one!(clauses, [])

      def one!(clauses, preload) when is_list(clauses) and is_list(preload) do
        Repo.one!(from(@model, where: ^clauses, preload: ^preload))
      rescue
        err -> {:error, err}
      end

      ##########################################################################
      @spec one(id | keyword(), list() | atom()) ::
              {:ok, @model.t()} | {:error, String.t()}
      def one(id) when is_binary(id), do: one([id: id], [])
      def one(id, preload) when is_binary(id) and is_list(preload), do: one([id: id], preload)
      def one(any, preload_atom) when is_atom(preload_atom), do: one(any, [preload_atom])
      def one(clauses) when is_list(clauses), do: one(clauses, [])

      def one(clauses, preload) when is_list(clauses) and is_list(preload) do
        case Repo.one(from(@model, where: ^clauses, preload: ^preload)) do
          nil -> {:error, "Nothing found"}
          result -> {:ok, result}
        end
      rescue
        err -> {:error, err}
      end
    end
  end
end
