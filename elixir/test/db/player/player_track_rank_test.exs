defmodule Rootbus.Db.PlayerTrackRankTest do
  use Rootbus.Test.Case, async: true

  doctest Db.PlayerTrackRank, import: true
  doctest Db.PlayerTrackRanks, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.PlayerTrackRank{} = player_track_rank = insert(:player_track_rank)
      assert player_track_rank.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:player_track_rank)
      changeset = Db.PlayerTrackRank.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:player_track_rank)
      assert %Db.PlayerTrackRank{} = found = Db.PlayerTrackRanks.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:player_track_rank)
      assert {:ok, player_track_rank} = Db.PlayerTrackRanks.create(attrs)
      assert player_track_rank.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      player_track_rank = insert(:player_track_rank)
      assert {:ok, deleted} = Db.PlayerTrackRanks.delete(player_track_rank)
      assert deleted.id == player_track_rank.id
    end
  end
end
