defmodule Rootbus.Db.WorldTest do
  use Rootbus.Test.Case, async: true

  doctest Db.World, import: true
  doctest Db.Worlds, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.World{} = world = insert(:world)
      assert world.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:world)
      changeset = Db.World.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:world)
      assert %Db.World{} = found = Db.Worlds.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:world)
      assert {:ok, world} = Db.Worlds.create(attrs)
      assert world.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      world = insert(:world)
      assert {:ok, deleted} = Db.Worlds.delete(world)
      assert deleted.id == world.id
    end
  end
end
