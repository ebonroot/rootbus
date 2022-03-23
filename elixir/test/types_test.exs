defmodule UtilsTypesTest do
  use ExUnit.Case
  doctest Utils.Types, import: true

  describe "to_existing_atom" do
    test "throws an ArgumentError" do
      assert_raise ArgumentError, fn ->
        Utils.Types.to_existing_atom("doesn't exist")
      end
    end
  end
end
