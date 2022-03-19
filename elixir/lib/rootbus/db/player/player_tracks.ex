defmodule Rootbus.Db.PlayerTracks do
  use Rootbus.Context
  use Rootbus.Db.CollectionUuid, model: Rootbus.Db.PlayerTrack
end
