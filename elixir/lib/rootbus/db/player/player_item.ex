defmodule Rootbus.Db.PlayerItem do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "player_items" do
    field(:item_type, :string)
    field(:position, :integer)
    field(:quantity, :integer)
    field(:meta, :map)
    timestamps()
  end

  @required_fields [:item_type]
  @update_fields [:position, :quantity, :meta]
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
