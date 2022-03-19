defmodule Rootbus.Db.BankLedgerTest do
  use Rootbus.Test.Case, async: true

  doctest Db.BankLedger, import: true
  doctest Db.BankLedgers, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.BankLedger{} = bank_ledger = insert(:bank_ledger)
      assert bank_ledger.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:bank_ledger)
      changeset = Db.BankLedger.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:bank_ledger)
      assert %Db.BankLedger{} = found = Db.BankLedgers.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:bank_ledger)
      assert {:ok, bank_ledger} = Db.BankLedgers.create(attrs)
      assert bank_ledger.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      bank_ledger = insert(:bank_ledger)
      assert {:ok, deleted} = Db.BankLedgers.delete(bank_ledger)
      assert deleted.id == bank_ledger.id
    end
  end
end
