defmodule Rootbus.Db.TeamTest do
  use Rootbus.Test.Case, async: true

  doctest Db.Team, import: true
  doctest Db.Teams, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.Team{} = team = insert(:team)
      assert team.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:team)
      changeset = Db.Team.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:team)
      assert %Db.Team{} = found = Db.Teams.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:team)
      assert {:ok, team} = Db.Teams.create(attrs)
      assert team.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      team = insert(:team)
      assert {:ok, deleted} = Db.Teams.delete(team)
      assert deleted.id == team.id
    end
  end
end
