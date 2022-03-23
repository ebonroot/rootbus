defmodule Ebonroot.Repo.Migrations.BaseMigration do
  @moduledoc false
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION citext", "DROP EXTENSION citext")

    ############################################################################
    create table(:users, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:name, :string)
      add(:type, :integer)
      timestamps()
    end

    ############################################################################
    create table(:players, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:user_id, references(:users, on_delete: :delete_all, type: :uuid), null: false)
      add(:gamemode, :integer, default: 0)
      add(:name, :string)
      timestamps()
    end

    ############################################################################
    create table(:worlds, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:server_id, :binary_id)
      add(:name, :citext)
      timestamps()
    end

    create(unique_index(:worlds, [:name]))

    ############################################################################
    create table(:locations, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:world_id, references(:worlds, on_delete: :delete_all, type: :uuid), null: false)
      add(:x, :float)
      add(:y, :float)
      add(:z, :float)
      add(:yaw, :float)
      add(:pitch, :float)
      timestamps()
    end

    ############################################################################
    create table(:player_tracks, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:name, :citext)
    end

    create(unique_index(:player_tracks, [:name]))

    create table(:player_track_ranks, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:track_id, references(:player_tracks, on_delete: :delete_all, type: :uuid), null: false)
      add(:name, :citext)
      add(:level, :integer)
    end

    create(unique_index(:player_track_ranks, [:track_id, :name]))

    create table(:player_ranks, primary_key: false) do
      add(:id, :uuid, primary_key: true)

      add(
        :player_id,
        references(:players, type: :uuid, on_delete: :delete_all),
        null: false
      )

      add(
        :rank_id,
        references(:player_track_ranks, type: :uuid, on_delete: :delete_all),
        null: false
      )

      add(
        :track_id,
        references(:player_tracks, type: :uuid, on_delete: :delete_all),
        null: false
      )

      # progress...
      add(:meta, :map)

      timestamps()
    end

    create(unique_index(:player_ranks, [:player_id, :track_id]))

    ############################################################################
    create table(:player_items, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:item_type, :string)
      # TBD: what all should be in this
      add(:meta, :map)
      add(:position, :integer)
      add(:quantity, :integer)
      timestamps()
    end

    ############################################################################
    # multi-maps
    create table(:player_items_carried, primary_key: false) do
      add(:player_id, references(:players, type: :uuid, on_delete: :delete_all),
        primary_key: true,
        null: false
      )

      add(:item_id, references(:player_items, type: :uuid, on_delete: :delete_all),
        primary_key: true,
        null: false
      )
    end

    create table(:player_items_worn, primary_key: false) do
      add(:player_id, references(:players, type: :uuid, on_delete: :delete_all),
        primary_key: true,
        null: false
      )

      add(:item_id, references(:player_items, type: :uuid, on_delete: :delete_all),
        primary_key: true,
        null: false
      )
    end

    create table(:player_items_hotbar, primary_key: false) do
      add(:player_id, references(:players, type: :uuid, on_delete: :delete_all),
        primary_key: true,
        null: false
      )

      add(:item_id, references(:player_items, type: :uuid, on_delete: :delete_all),
        primary_key: true,
        null: false
      )
    end

    create table(:player_homes, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:player_id, references(:players, type: :uuid, on_delete: :delete_all), null: false)
      add(:location_id, references(:locations, type: :uuid, on_delete: :delete_all), null: false)
      add(:name, :citext)
      timestamps()
    end

    create(unique_index(:player_homes, [:name]))

    # create table(:player_beds, primary_key: false) do
    #   add(:id, :uuid, primary_key: true)
    #   add(:player_id, references(:players, type: :uuid, on_delete: :delete_all),
    #     primary_key: true,
    #     null: false
    #   )
    #
    #   add(:location_id, references(:locations, type: :uuid, on_delete: :delete_all),
    #     primary_key: true,
    #     null: false
    #   )
    #   add(:name, :citext)
    # end
    # create unique_index(:player_homes, [:name])

    ############################################################################
    create table(:player_logs, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:player_id, references(:players, on_delete: :delete_all, type: :uuid), null: false)
      add(:action, :integer)
      add(:ipaddr, :string, default: "")
      timestamps()
    end

    ############################################################################
    create table(:player_settings, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:player_id, references(:players, on_delete: :delete_all, type: :uuid), null: false)
      add(:name, :citext)
      add(:type, :integer)
      add(:int, :integer)
      add(:bool, :boolean)
      add(:str, :string)
      timestamps()
    end

    create(unique_index(:player_settings, [:player_id, :type, :name]))

    ############################################################################
    create table(:player_sheets, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:player_id, references(:players, on_delete: :delete_all, type: :uuid), null: false)
      add(:health, :integer)
      add(:health_scale, :integer)
      add(:health_max, :integer)
      add(:food, :integer)
      add(:air, :integer)
      add(:air_max, :integer)
      timestamps()
    end

    ############################################################################
    create table(:player_effects, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:player_id, references(:players, on_delete: :delete_all, type: :uuid), null: false)
      add(:name, :string)
      add(:duration, :integer)
      timestamps()
    end

    ############################################################################
    create table(:shops, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:location_id, references(:locations, on_delete: :delete_all, type: :uuid), null: false)
      add(:player_id, references(:players, on_delete: :delete_all, type: :uuid), null: false)
      add(:item_type, :citext)
      add(:buy_price, :float)
      add(:sell_price, :float)
      add(:settings, :map)
      timestamps()
    end

    ############################################################################
    create table(:warps, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:player_id, references(:players, on_delete: :delete_all, type: :uuid), null: false)
      add(:location_id, references(:locations, on_delete: :delete_all, type: :uuid), null: false)
      add(:name, :citext)
      timestamps()
    end

    create(unique_index(:warps, [:name]))

    ############################################################################
    create table(:lands, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:name, :citext)
      add(:world_id, references(:worlds, on_delete: :delete_all, type: :uuid), null: false)
      add(:type, :integer)
      add(:title, :citext)
      add(:spawn_id, references(:locations, on_delete: :delete_all, type: :uuid), null: true)
      # add(:shield ???
      # add(:category ???
      add(:claimed_chunks, :integer)
      # add(:area_total, :integer)
      add(:stats, :map)
      # "worlds"
      add(:config, :map)
      timestamps()
    end

    create(unique_index(:lands, [:name]))

    create table(:land_members, primary_key: false) do
      add(:id, :uuid, primary_key: true)

      add(:player_id, references(:players, type: :uuid, null: false, on_delete: :delete_all))

      add(:land_id, references(:lands, type: :uuid, null: false, on_delete: :delete_all))

      add(:contributed_chunks, :integer)
      add(:type, :integer)
      # "vs" column from Lands ... is what?
      add(:meta, :map)
      timestamps()
    end

    create table(:land_invites, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:player_id, references(:players, type: :uuid, null: false, on_delete: :delete_all))
      add(:land_id, references(:lands, type: :uuid, null: false, on_delete: :delete_all))
      add(:expires, :utc_datetime)
      timestamps()
    end

    create(unique_index(:land_invites, [:player_id, :land_id]))

    # nations
    #   - name
    #   - capital
    #   - taxes
    #   - inbox??
    #   - effects??
    # nation_lands
    #   - nation_id
    #   - land_id
    # Log of activity; aka "inbox"
    # wars...

    ############################################################################
    create table(:bank_accounts, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:player_id, references(:players, on_delete: :delete_all, type: :uuid), null: true)
      add(:shop_id, references(:shops, on_delete: :delete_all, type: :uuid), null: true)
      add(:land_id, references(:lands, on_delete: :delete_all, type: :uuid), null: true)
      add(:name, :citext)
      add(:type, :integer)
      add(:balance, :float)
      timestamps()
    end

    ############################################################################
    create table(:bank_ledgers, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:player_id, references(:players, on_delete: :delete_all, type: :uuid), null: false)

      add(:account_id, references(:bank_accounts, on_delete: :delete_all, type: :uuid),
        null: false
      )

      add(:amount, :float)
      add(:memo, :string)
      timestamps()
    end

    ############################################################################
    create table(:teams, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      # persistent, session, ...
      add(:type, :integer)
      add(:name, :string)
      add(:meta, :map)
      # # active == currently players are online
      # add(:active, :boolean)
      timestamps()
    end

    create table(:team_members, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:player_id, references(:players, type: :uuid, null: false, on_delete: :delete_all))
      add(:team_id, references(:teams, type: :uuid, null: false, on_delete: :delete_all))
      add(:type, :integer)
      timestamps()
    end

    # Future:
    # * Perms
    # * Blacklist
    # * Mail?
    # * friend groups (unassociated with anything else)
  end
end
