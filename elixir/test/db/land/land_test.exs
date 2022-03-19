defmodule Rootbus.Db.LandTest do
  use Rootbus.Test.Case, async: true

  doctest Db.Land, import: true
  doctest Db.Lands, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.Land{} = land = insert(:land)
      assert land.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:land)
      changeset = Db.Land.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:land)
      assert %Db.Land{} = found = Db.Lands.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:land)
      assert {:ok, land} = Db.Lands.create(attrs)
      assert land.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      land = insert(:land)
      assert {:ok, deleted} = Db.Lands.delete(land)
      assert deleted.id == land.id
    end
  end
end
