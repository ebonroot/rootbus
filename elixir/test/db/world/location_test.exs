defmodule Rootbus.Db.LocationTest do
  use Rootbus.Test.Case, async: true

  doctest Db.Location, import: true
  doctest Db.Locations, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.Location{} = location = insert(:location)
      assert location.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:location)
      changeset = Db.Location.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:location)
      assert %Db.Location{} = found = Db.Locations.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:location)
      assert {:ok, location} = Db.Locations.create(attrs)
      assert location.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      location = insert(:location)
      assert {:ok, deleted} = Db.Locations.delete(location)
      assert deleted.id == location.id
    end
  end
end
