defmodule Rootbus.Db.PlayerEffects do
  use Rootbus.Context
  use Rootbus.Db.CollectionUuid, model: Rootbus.Db.PlayerEffect
end
