defmodule Rootbus.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :rootbus,
    #    adapter: Ecto.Adapters.MySQL
    adapter: Ecto.Adapters.Postgres
end
