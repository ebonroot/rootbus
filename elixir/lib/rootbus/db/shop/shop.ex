defmodule Rootbus.Db.Shop do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  typed_schema "shops" do
    belongs_to(:location, Db.Location)
    belongs_to(:player, Db.Player)
    field(:item_type, :string)
    field(:buy_price, :float)
    field(:sell_price, :float)
    field(:settings, :map)
    timestamps()
  end

  @required_fields [:location_id, :player_id, :item_type]
  @update_fields [:buy_price, :sell_price, :item_type, :settings]
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
