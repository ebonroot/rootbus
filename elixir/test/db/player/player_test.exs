defmodule Rootbus.Db.PlayerTest do
  use Rootbus.Test.Case, async: true

  doctest Db.Player, import: true
  doctest Db.Players, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.Player{} = player = insert(:player)
      assert player.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:player)
      changeset = Db.Player.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:player)
      assert %Db.Player{} = found = Db.Players.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:player)
      assert {:ok, player} = Db.Players.create(attrs)
      assert player.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      player = insert(:player)
      assert {:ok, deleted} = Db.Players.delete(player)
      assert deleted.id == player.id
    end
  end
end
