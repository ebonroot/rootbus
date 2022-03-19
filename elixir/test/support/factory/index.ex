defmodule Rootbus.Test.Factory do
  use ExMachina.Ecto, repo: Rootbus.Repo

  use Rootbus.Test.Factory.Bank
  use Rootbus.Test.Factory.Land
  use Rootbus.Test.Factory.Player
  use Rootbus.Test.Factory.Shop
  use Rootbus.Test.Factory.World
end
