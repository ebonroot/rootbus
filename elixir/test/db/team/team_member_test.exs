defmodule Rootbus.Db.TeamMemberTest do
  use Rootbus.Test.Case, async: true

  doctest Db.TeamMember, import: true
  doctest Db.TeamMembers, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.TeamMember{} = team_member = insert(:team_member)
      assert team_member.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:team_member)
      changeset = Db.TeamMember.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:team_member)
      assert %Db.TeamMember{} = found = Db.TeamMembers.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:team_member)
      assert {:ok, team_member} = Db.TeamMembers.create(attrs)
      assert team_member.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      team_member = insert(:team_member)
      assert {:ok, deleted} = Db.TeamMembers.delete(team_member)
      assert deleted.id == team_member.id
    end
  end
end
