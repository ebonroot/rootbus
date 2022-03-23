defmodule Rootbus.Ecto do
  defmacro __using__(_) do
    quote location: :keep do
      use TypedEctoSchema
      use Rootbus.Context
      import Ecto.Changeset
      import EctoEnum
    end
  end
end
