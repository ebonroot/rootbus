import Config

config :rootbus, ecto_repos: [Rootbus.Repo]

config :rootbus, Rootbus.Repo,
  username: "postgres",
  password: "",
  database: "rootbus_#{config_env()}",
  hostname: "db",
  log: false

import_config "#{config_env()}.exs"
