defmodule Rootbus.Db.LandInviteTest do
  use Rootbus.Test.Case, async: true

  doctest Db.LandInvite, import: true
  doctest Db.LandInvites, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.LandInvite{} = land_invite = insert(:land_invite)
      assert land_invite.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:land_invite)
      changeset = Db.LandInvite.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:land_invite)
      assert %Db.LandInvite{} = found = Db.LandInvites.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:land_invite)
      assert {:ok, land_invite} = Db.LandInvites.create(attrs)
      assert land_invite.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      land_invite = insert(:land_invite)
      assert {:ok, deleted} = Db.LandInvites.delete(land_invite)
      assert deleted.id == land_invite.id
    end
  end
end
