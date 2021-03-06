# cloned from original repo to fix to_existing_atom
defmodule Ecto.DangerousAtom do
  @moduledoc """

  Custom Type to support `:atom`

  defmodule Post do
    use Ecto.Schema
    schema "posts" do
      field :atom_field, Ecto.Atom
    end
  end
  """

  @behaviour Ecto.Type
  @type t :: atom()

  def type, do: :string

  def embed_as(_), do: :self

  def cast(value) when is_atom(value), do: {:ok, value}
  def cast(value) when is_binary(value), do: {:ok, Utils.Types.to_atom(value)}
  def cast(_), do: :error

  def load(value), do: {:ok, Utils.Types.to_atom(value)}

  def dump(value) when is_atom(value), do: {:ok, Atom.to_string(value)}
  def dump(_), do: :error

  def equal?(a, b), do: a == b
end
