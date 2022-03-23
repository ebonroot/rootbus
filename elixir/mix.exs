defmodule Rootbus.MixProject do
  use Mix.Project

  def project do
    [
      app: :rootbus,
      version: "1.0.0",
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      aliases: aliases(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test
      ],
      dialyzer: [
        # ignore_warnings: ".dialyzer_ignore.exs",
        plt_add_apps: [:mix],
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :postgrex, :ecto, :timex, {:ex_unit, :optional}],
      mod: {Rootbus.Application, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "seeds"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"],
      c: ["compile"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:excoveralls, "~> 0.14", only: :test},
      {:ex_machina, "~> 2.7.0", only: :test},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ecto_enum, "~> 1.4"},
      {:ecto_sql, "~> 3.4", override: true},
      {:typed_ecto_schema, "~> 0.3.0"},
      {:postgrex, "~> 0.13"},
      {:faker, "~> 0.10", only: :test},
      {:timex, "~> 3.6"},
      {:mix_test_watch, "~> 0.8", only: [:test, :dev], runtime: false},
      {:jason, "~> 1.2.2"},
      {:uuid, "~> 1.1"},
      {:protobuf, "~> 0.7.1"},
      {:junit_formatter, "~> 3.1", only: [:test]}
    ]
  end
end
