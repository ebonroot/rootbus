defmodule Rootbus.Db.BankAccountTest do
  use Rootbus.Test.Case, async: true

  doctest Db.BankAccount, import: true
  doctest Db.BankAccounts, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.BankAccount{} = bank_account = insert(:bank_account)
      assert bank_account.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:bank_account)
      changeset = Db.BankAccount.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:bank_account)
      assert %Db.BankAccount{} = found = Db.BankAccounts.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:bank_account)
      assert {:ok, bank_account} = Db.BankAccounts.create(attrs)
      assert bank_account.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      bank_account = insert(:bank_account)
      assert {:ok, deleted} = Db.BankAccounts.delete(bank_account)
      assert deleted.id == bank_account.id
    end
  end
end
