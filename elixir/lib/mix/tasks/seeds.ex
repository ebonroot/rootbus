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

    tracks = ["Chromatic", "Gemstone"]

    [chr_track, gem_track] =
      Enum.map(tracks, fn track ->
        {:ok, track} =
          Db.PlayerTracks.create(%{
            name: track
          })

        track
      end)

    chr_ranks = [
      {1, "Beginner"},
      {2, "Apprentice"},
      {3, "Explorer"},
      {4, "Builder"},
      {5, "Journeyman"},
      {6, "Expert"},
      {7, "Artisan"},
      {8, "Maven"},
      {9, "Master"},
      {10, "Grandmaster"}
    ]

    gem_ranks = [
      {1, "VIP"},
      {2, "Elite"},
      {3, "Champion"},
      {4, "Veteran"},
      {5, "Hero"},
      {6, "Legend"},
      {8, "Saint"},
      {10, "Titan"},
      {12, "Eternal"},
      {15, "Immortal"}
    ]

    map_ranks(chr_track, chr_ranks)
    map_ranks(gem_track, gem_ranks)
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

  ##############################################################################
  defp map_ranks(track, ranks) do
    Enum.each(ranks, fn {level, name} ->
      {:ok, _} =
        Db.PlayerTrackRanks.create(%{
          track_id: track.id,
          name: name,
          level: level
        })
    end)
  end
end
