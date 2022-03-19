defmodule Rootbus.Test.Factory.Player do
  use Rootbus.Context

  defmacro __using__(_opts) do
    quote location: :keep do
      def player_factory do
        %Db.Player{
          id: Ecto.UUID.generate(),
          user: build(:user),
          name: Faker.Pokemon.name()
        }
      end

      def player_effect_factory do
        %Db.PlayerEffect{
          player: build(:player),
          name: Faker.Superhero.power(),
          duration: 50
        }
      end

      def player_item_factory do
        %Db.PlayerItem{
          player: build(:player),
          name: Faker.Industry.industry(),
          position: 32,
          quantity: 1
        }
      end

      def player_log_factory do
        %Db.PlayerLog{
          player: build(:player),
          action: :login,
          ipaddr: Faker.Internet.ip_v4_address()
        }
      end

      def player_setting_factory do
        type = Enum.random(Rootbus.Db.PlayerSetting.Type.__valid_values__())

        struct = %Db.PlayerSetting{
          player: build(:player),
          type: type
        }

        case Enum.random([:int, :str, :bool]) do
          :int ->
            %{struct | int: :rand.uniform(1_000_000)}

          :str ->
            %{struct | str: Faker.Lorem.sentence()}

          :bool ->
            %{struct | bool: true}
        end
      end

      def player_sheet_factory do
        %Db.PlayerSheet{
          player: build(:player),
          health: 100,
          health_scale: 100,
          health_max: 100,
          food: 40,
          air: 50,
          air_max: 100
        }
      end

      def player_rank_factory do
        %Db.PlayerRank{
          player: build(:player),
          rank: build(:player_track_rank),
          track: build(:player_track)
        }
      end

      def player_track_factory do
        %Db.PlayerTrack{
          name: Faker.Team.creature()
        }
      end

      def player_track_rank_factory do
        %Db.PlayerTrackRank{
          track: build(:player_track),
          name: Faker.Superhero.descriptor(),
          level: 1
        }
      end

      def user_factory do
        %Db.User{
          name: Faker.Person.name(),
          type: :unknown
        }
      end
    end
  end
end
