defmodule Rootbus.Db.Teams do
  use Rootbus.Context
  use Rootbus.Db.CollectionUuid, model: Rootbus.Db.Team
end
