defmodule Rootbus.Test.Factory.Land do
  use Rootbus.Context

  defmacro __using__(_opts) do
    quote location: :keep do
      def land_factory do
        %Db.Land{
          world: build(:world),
          name: Faker.Address.city()
        }
      end

      def land_member_factory do
        %Db.LandMember{
          land: build(:land),
          player: build(:player),
          type: :owner
        }
      end

      def land_invite_factory do
        %Db.LandInvite{
          land: build(:land),
          player: build(:player),
          expires: Timex.now()
        }
      end
    end
  end
end
