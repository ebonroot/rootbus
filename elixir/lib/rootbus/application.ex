defmodule Rootbus.Application do
  @moduledoc """
  An application that owns the core business entities and business logic.
  """

  use Application

  def start(_type, _args) do
    children = [
      {Rootbus.Repo, []}
      # Rootbus.Scheduler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Rootbus.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
