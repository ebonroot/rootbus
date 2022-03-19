defmodule Rootbus.Db.PlayerSheetTest do
  use Rootbus.Test.Case, async: true

  doctest Db.PlayerSheet, import: true
  doctest Db.PlayerSheets, import: true

  describe "factory" do
    test "factory creates a valid instance" do
      assert %Db.PlayerSheet{} = player_sheet = insert(:player_sheet)
      assert player_sheet.id != nil
    end
  end

  describe "build/1" do
    test "build when valid" do
      params = params_with_assocs(:player_sheet)
      changeset = Db.PlayerSheet.build(params)
      assert changeset.valid?
    end
  end

  describe "get/1" do
    test "loads saved transactions as expected" do
      c = insert(:player_sheet)
      assert %Db.PlayerSheet{} = found = Db.PlayerSheets.one!(id: c.id)
      assert found.id == c.id
    end
  end

  describe "create/1" do
    test "inserts a valid record" do
      attrs = params_with_assocs(:player_sheet)
      assert {:ok, player_sheet} = Db.PlayerSheets.create(attrs)
      assert player_sheet.id != nil
    end
  end

  describe "delete/1" do
    test "deletes record" do
      player_sheet = insert(:player_sheet)
      assert {:ok, deleted} = Db.PlayerSheets.delete(player_sheet)
      assert deleted.id == player_sheet.id
    end
  end
end
