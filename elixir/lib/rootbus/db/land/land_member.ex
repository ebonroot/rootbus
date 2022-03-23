defmodule Rootbus.Db.LandMember do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  defenum(Type, owner: 1, member: 2)

  typed_schema "land_members" do
    belongs_to(:player, Db.Player)
    belongs_to(:land, Db.Land)
    field(:type, Type)
    timestamps()
  end

  @required_fields [:player_id, :land_id, :type]
  @update_fields [:type]
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
