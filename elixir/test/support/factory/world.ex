defmodule Rootbus.Test.Factory.World do
  use Rootbus.Context

  defmacro __using__(_opts) do
    quote location: :keep do
      def location_factory do
        %Db.Location{
          world: build(:world),
          x: -100.10101,
          y: 53.01,
          z: 202.20202,
          yaw: 10.02,
          pitch: 4.4
        }
      end

      def warp_factory do
        %Db.Warp{
          name: Faker.Pokemon.name(),
          location: build(:location),
          player: build(:player)
        }
      end

      def world_factory do
        %Db.World{
          server_id: Ecto.UUID.generate(),
          name: Faker.Food.ingredient()
        }
      end
    end
  end
end
