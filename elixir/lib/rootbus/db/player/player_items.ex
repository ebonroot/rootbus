defmodule Rootbus.Db.PlayerItems do
  use Rootbus.Context
  use Rootbus.Db.CollectionUuid, model: Rootbus.Db.PlayerItem
end
