defmodule Rootbus.Db.PlayerInvites do
  use Rootbus.Context
  use Rootbus.Db.CollectionUuid, model: Rootbus.Db.PlayerInvite
end
