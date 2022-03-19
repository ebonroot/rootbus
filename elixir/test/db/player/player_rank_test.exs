defmodule Rootbus.Db.PlayerRankTest do
  use Rootbus.Test.Case, async: true

  doctest Db.PlayerRank, import: true
  doctest Db.PlayerRanks, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.PlayerRank{} = player_rank = insert(:player_rank)
      assert player_rank.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:player_rank)
      changeset = Db.PlayerRank.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:player_rank)
      assert %Db.PlayerRank{} = found = Db.PlayerRanks.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:player_rank)
      assert {:ok, player_rank} = Db.PlayerRanks.create(attrs)
      assert player_rank.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      player_rank = insert(:player_rank)
      assert {:ok, deleted} = Db.PlayerRanks.delete(player_rank)
      assert deleted.id == player_rank.id
    end
  end
end
