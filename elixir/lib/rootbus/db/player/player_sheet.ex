defmodule Rootbus.Db.PlayerSheet do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  typed_schema "player_sheets" do
    belongs_to(:player, Db.Player)
    field(:health, :integer)
    field(:health_scale, :integer)
    field(:health_max, :integer)
    field(:food, :integer)
    field(:air, :integer)
    field(:air_max, :integer)
    timestamps()
  end

  @required_fields [:player_id]
  @update_fields [:health, :health_scale, :health_max, :food, :air, :air_max]
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
