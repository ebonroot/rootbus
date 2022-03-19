defmodule Rootbus.Db.PlayerTrackTest do
  use Rootbus.Test.Case, async: true

  doctest Db.PlayerTrack, import: true
  doctest Db.PlayerTracks, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.PlayerTrack{} = player_track = insert(:player_track)
      assert player_track.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:player_track)
      changeset = Db.PlayerTrack.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:player_track)
      assert %Db.PlayerTrack{} = found = Db.PlayerTracks.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:player_track)
      assert {:ok, player_track} = Db.PlayerTracks.create(attrs)
      assert player_track.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      player_track = insert(:player_track)
      assert {:ok, deleted} = Db.PlayerTracks.delete(player_track)
      assert deleted.id == player_track.id
    end
  end
end
