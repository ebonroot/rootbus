defmodule Rootbus.Context do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @timestamps_opts [type: :utc_datetime]
      import Ecto, only: [assoc: 2]
      import Ecto.Changeset
      import Ecto.Query, except: [update: 2, update: 3]
      # alias Ecto.Multi
      alias Ecto.Changeset
      alias Rootbus.Repo
      alias Rootbus.Db
    end
  end
end
