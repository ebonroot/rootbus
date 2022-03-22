defmodule Rootbus.Db.TeamMembers do
  use Rootbus.Context
  use Rootbus.Db.CollectionUuid, model: Rootbus.Db.TeamMember
end
