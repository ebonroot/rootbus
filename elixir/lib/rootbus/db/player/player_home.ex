defmodule Rootbus.Db.PlayerHome do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  typed_schema "player_homes" do
    belongs_to(:player, Db.Player)
    belongs_to(:location, Db.Location)
    field(:name, :string)
    timestamps()
  end

  @required_fields [:player_id, :location_id, :name]
  @update_fields [:name]
  @create_fields @required_fields ++ @update_fields

  def validate(chgset) do
    chgset
    |> validate_required(@required_fields)
  end

  @doc """
  Build a changeset for creating a new PlayerHome.
  """
  def build(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, @create_fields)
    |> validate
  end

  @doc """
  Changeset for performing updates to a PlayerHome.
  """
  def changeset(item, attrs) do
    item
    |> cast(attrs, @update_fields)
    |> validate
  end
end
