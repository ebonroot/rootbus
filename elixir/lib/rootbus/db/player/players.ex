defmodule Rootbus.Db.Players do
  use Rootbus.Context
  use Rootbus.Db.CollectionUuid, model: Rootbus.Db.Player
end
