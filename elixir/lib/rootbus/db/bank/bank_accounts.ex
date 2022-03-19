defmodule Rootbus.Db.BankAccounts do
  use Rootbus.Context
  use Rootbus.Db.CollectionUuid, model: Rootbus.Db.BankAccount
end
