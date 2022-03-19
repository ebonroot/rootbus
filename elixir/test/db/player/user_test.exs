defmodule Rootbus.Db.UserTest do
  use Rootbus.Test.Case, async: true

  doctest Db.User, import: true
  doctest Db.Users, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.User{} = user = insert(:user)
      assert user.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:user)
      changeset = Db.User.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:user)
      assert %Db.User{} = found = Db.Users.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:user)
      assert {:ok, user} = Db.Users.create(attrs)
      assert user.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      user = insert(:user)
      assert {:ok, deleted} = Db.Users.delete(user)
      assert deleted.id == user.id
    end
  end
end
