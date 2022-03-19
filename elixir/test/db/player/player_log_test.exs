defmodule Rootbus.Db.PlayerLogTest do
  use Rootbus.Test.Case, async: true

  doctest Db.PlayerLog, import: true
  doctest Db.PlayerLogs, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.PlayerLog{} = player_log = insert(:player_log)
      assert player_log.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:player_log)
      changeset = Db.PlayerLog.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:player_log)
      assert %Db.PlayerLog{} = found = Db.PlayerLogs.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:player_log)
      assert {:ok, player_log} = Db.PlayerLogs.create(attrs)
      assert player_log.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      player_log = insert(:player_log)
      assert {:ok, deleted} = Db.PlayerLogs.delete(player_log)
      assert deleted.id == player_log.id
    end
  end
end
