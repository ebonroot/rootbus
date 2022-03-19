defmodule Rootbus.Db.PlayerHomeTest do
  use Rootbus.Test.Case, async: true

  doctest Db.PlayerHome, import: true
  doctest Db.PlayerHomes, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.PlayerHome{} = player_home = insert(:player_home)
      assert player_home.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:player_home)
      changeset = Db.PlayerHome.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:player_home)
      assert %Db.PlayerHome{} = found = Db.PlayerHomes.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:player_home)
      assert {:ok, player_home} = Db.PlayerHomes.create(attrs)
      assert player_home.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      player_home = insert(:player_home)
      assert {:ok, deleted} = Db.PlayerHomes.delete(player_home)
      assert deleted.id == player_home.id
    end
  end
end
