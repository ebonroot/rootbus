defmodule Rootbus.Db.Player do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id

  defenum(GameMode, survival: 0, creative: 1, hardcore: 2, adventure: 3)

  schema "players" do
    belongs_to(:user, Db.User)
    # move to settings?
    field(:gamemode, GameMode, default: :survival)
    field(:name, :string)
    has_many(:logs, Db.PlayerLog)
    has_many(:ranks, Db.PlayerRank)
    many_to_many(:carried, Db.PlayerItem, join_through: "player_items_carried")
    many_to_many(:worn, Db.PlayerItem, join_through: "player_items_worn")
    many_to_many(:hotbar, Db.PlayerItem, join_through: "player_items_hotbar")
    has_many(:settings, Db.PlayerSetting)
    has_many(:effects, Db.PlayerEffect)
    many_to_many(:homes, Db.Location, join_through: "player_homes")
    many_to_many(:beds, Db.Location, join_through: "player_beds")
    has_many(:lands, Db.LandMember)
    has_many(:warps, Db.Warp)
    has_one(:sheet, Db.PlayerSheet)
    has_one(:bank, Db.BankAccount)
    # TBD: has_many(:perms); repeated GroupPerms... map<string, Perm> perms = X;
    timestamps()
  end

  @required_fields [:id]
  @update_fields [:user_id, :name, :gamemode]
  @create_fields @required_fields ++ @update_fields

  def validate(chgset) do
    chgset
    |> validate_required(@required_fields)
  end

  def build(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, @create_fields)
    |> validate
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, @update_fields)
    |> validate
  end
end
