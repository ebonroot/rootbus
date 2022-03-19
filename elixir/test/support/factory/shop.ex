defmodule Rootbus.Test.Factory.Shop do
  use Rootbus.Context

  defmacro __using__(_opts) do
    quote location: :keep do
      def shop_factory do
        %Db.Shop{
          location: build(:location),
          player: build(:player)
        }
      end
    end
  end
end
