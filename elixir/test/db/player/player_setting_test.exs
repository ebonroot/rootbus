defmodule Rootbus.Db.PlayerSettingTest do
  use Rootbus.Test.Case, async: true

  doctest Db.PlayerSetting, import: true
  doctest Db.PlayerSettings, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.PlayerSetting{} = player_setting = insert(:player_setting)
      assert player_setting.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:player_setting)
      changeset = Db.PlayerSetting.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:player_setting)
      assert %Db.PlayerSetting{} = found = Db.PlayerSettings.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:player_setting)
      assert {:ok, player_setting} = Db.PlayerSettings.create(attrs)
      assert player_setting.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      player_setting = insert(:player_setting)
      assert {:ok, deleted} = Db.PlayerSettings.delete(player_setting)
      assert deleted.id == player_setting.id
    end
  end
end
