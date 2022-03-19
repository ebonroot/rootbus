defmodule Mix.Tasks.Seeds do
  use Mix.Task
  use Rootbus.Context
  # use Rootbus.TestDefinitions
  # alias Mix.Tasks.Rootbus.Tools

  @moduledoc """
  Seed the database with the admin
  """
  @shortdoc "Seed the database with data to run or demo the platform."

  ##############################################################################
  def start_friends() do
    Mix.Task.run("app.start")
    # Faker.start()
  end

  ##############################################################################
  def run([]), do: run([Mix.env()])

  def run(args) do
    start_friends()

    Enum.each(args, fn arg ->
      seed(arg)
    end)
  end

  # break out for individual env settings as desired
  def seed(env) when env in [:dev, :test, :prod] do
    seed(:all)
  end

  ##############################################################################
  def seed(:all) do
    IO.puts("Basic seeding for all environments")

    ["Chromatic", "Gemstone"]
    |> Enum.each(fn track ->
      {:ok, t} =
        Db.PlayerTracks.create(%{
          name: track
        })
    end)
  end

  def seed(_) do
    IO.puts("""
    Syntax: mix seeds {seed}[ {seed}...]

      - with no seed it defaults to Mix.env() (dev/test/prod)

      dev, test, prod - do seeds for the environment
      user={tenant:email:password}
                   - create a user, if user is unspecified will generate one
      admin={userId}
                   - make userId(uuid) an admin
      settings     - add some settings for development
      journeys={Owner's userId}@{path-to-import-file}
                   - seed the Product Journey Map and Challenges.
      topic-schema={path-to-import-file}

    """)
  end
end
