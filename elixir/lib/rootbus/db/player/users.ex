defmodule Rootbus.Db.Users do
  use Rootbus.Context
  use Rootbus.Db.CollectionUuid, model: Rootbus.Db.User
end
