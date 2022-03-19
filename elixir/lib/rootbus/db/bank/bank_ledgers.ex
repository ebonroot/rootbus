defmodule Rootbus.Db.BankLedgers do
  use Rootbus.Context
  use Rootbus.Db.CollectionUuid, model: Rootbus.Db.BankLedger
end
