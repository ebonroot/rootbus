defmodule Rootbus.Db.WarpTest do
  use Rootbus.Test.Case, async: true

  doctest Db.Warp, import: true
  doctest Db.Warps, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.Warp{} = warp = insert(:warp)
      assert warp.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:warp)
      changeset = Db.Warp.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:warp)
      assert %Db.Warp{} = found = Db.Warps.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:warp)
      assert {:ok, warp} = Db.Warps.create(attrs)
      assert warp.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      warp = insert(:warp)
      assert {:ok, deleted} = Db.Warps.delete(warp)
      assert deleted.id == warp.id
    end
  end
end
