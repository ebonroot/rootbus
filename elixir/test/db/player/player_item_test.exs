defmodule Rootbus.Db.PlayerItemTest do
  use Rootbus.Test.Case, async: true

  doctest Db.PlayerItem, import: true
  doctest Db.PlayerItems, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.PlayerItem{} = player_item = insert(:player_item)
      assert player_item.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:player_item)
      changeset = Db.PlayerItem.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:player_item)
      assert %Db.PlayerItem{} = found = Db.PlayerItems.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:player_item)
      assert {:ok, player_item} = Db.PlayerItems.create(attrs)
      assert player_item.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      player_item = insert(:player_item)
      assert {:ok, deleted} = Db.PlayerItems.delete(player_item)
      assert deleted.id == player_item.id
    end
  end
end
