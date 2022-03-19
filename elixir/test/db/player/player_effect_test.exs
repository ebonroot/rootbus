defmodule Rootbus.Db.PlayerEffectTest do
  use Rootbus.Test.Case, async: true

  doctest Db.PlayerEffect, import: true
  doctest Db.PlayerEffects, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.PlayerEffect{} = player_effect = insert(:player_effect)
      assert player_effect.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:player_effect)
      changeset = Db.PlayerEffect.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:player_effect)
      assert %Db.PlayerEffect{} = found = Db.PlayerEffects.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:player_effect)
      assert {:ok, player_effect} = Db.PlayerEffects.create(attrs)
      assert player_effect.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      player_effect = insert(:player_effect)
      assert {:ok, deleted} = Db.PlayerEffects.delete(player_effect)
      assert deleted.id == player_effect.id
    end
  end
end
