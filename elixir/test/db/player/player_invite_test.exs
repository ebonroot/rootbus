defmodule Rootbus.Db.PlayerInviteTest do
  use Rootbus.Test.Case, async: true

  doctest Db.PlayerInvite, import: true
  doctest Db.PlayerInvites, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.PlayerInvite{} = player_invite = insert(:player_invite)
      assert player_invite.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:player_invite)
      changeset = Db.PlayerInvite.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:player_invite)
      assert %Db.PlayerInvite{} = found = Db.PlayerInvites.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:player_invite)
      assert {:ok, player_invite} = Db.PlayerInvites.create(attrs)
      assert player_invite.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      player_invite = insert(:player_invite)
      assert {:ok, deleted} = Db.PlayerInvites.delete(player_invite)
      assert deleted.id == player_invite.id
    end
  end
end
