defmodule Rootbus.Db.ShopTest do
  use Rootbus.Test.Case, async: true

  doctest Db.Shop, import: true
  doctest Db.Shops, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.Shop{} = shop = insert(:shop)
      assert shop.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:shop)
      changeset = Db.Shop.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:shop)
      assert %Db.Shop{} = found = Db.Shops.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:shop)
      assert {:ok, shop} = Db.Shops.create(attrs)
      assert shop.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      shop = insert(:shop)
      assert {:ok, deleted} = Db.Shops.delete(shop)
      assert deleted.id == shop.id
    end
  end
end
