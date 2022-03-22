defmodule Rootbus.Test.Factory.Team do
  use Rootbus.Context

  defmacro __using__(_opts) do
    quote location: :keep do
      def team_factory do
        %Db.Team{
          type: :session,
          name: Faker.Pokemon.name()
        }
      end

      def team_member_factory do
        %Db.TeamMember{
          player: build(:player),
          team: build(:team),
          type: :member
        }
      end
    end
  end
end
