defmodule Rootbus.Db.LandMemberTest do
  use Rootbus.Test.Case, async: true

  doctest Db.LandMember, import: true
  doctest Db.LandMembers, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.LandMember{} = land_member = insert(:land_member)
      assert land_member.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:land_member)
      changeset = Db.LandMember.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:land_member)
      assert %Db.LandMember{} = found = Db.LandMembers.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:land_member)
      assert {:ok, land_member} = Db.LandMembers.create(attrs)
      assert land_member.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      land_member = insert(:land_member)
      assert {:ok, deleted} = Db.LandMembers.delete(land_member)
      assert deleted.id == land_member.id
    end
  end
end
