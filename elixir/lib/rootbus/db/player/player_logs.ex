defmodule Rootbus.Db.PlayerLogs do
  use Rootbus.Context
  use Rootbus.Db.CollectionUuid, model: Rootbus.Db.PlayerLog
end
