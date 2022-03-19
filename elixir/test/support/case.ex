defmodule Rootbus.Test.Case do
  use ExUnit.CaseTemplate

  using do
    quote location: :keep do
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      alias Ecto.Changeset
      import Rootbus.Test.Case
      import Rootbus.Test.Factory
      use Rootbus.Context
    end
  end

  setup tags do
    opts = tags |> Map.take([:isolation]) |> Enum.to_list()
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Rootbus.Repo, opts)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Rootbus.Repo, {:shared, self()})
    end

    :ok
  end
end
