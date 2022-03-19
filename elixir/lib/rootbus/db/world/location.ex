defmodule Rootbus.Db.Location do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "locations" do
    belongs_to(:world, Db.World)
    field(:x, :float)
    field(:y, :float)
    field(:z, :float)
    field(:yaw, :float)
    field(:pitch, :float)
    timestamps()
  end

  @required_fields [:world_id, :x, :y, :z]
  @update_fields [:yaw, :pitch]
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
