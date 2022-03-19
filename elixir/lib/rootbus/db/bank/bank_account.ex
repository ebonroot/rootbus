defmodule Rootbus.Db.BankAccount do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  defenum(Type, player: 0, shop: 1, land: 2)

  schema "bank_accounts" do
    belongs_to(:player, Db.Player)
    belongs_to(:shop, Db.Shop)
    belongs_to(:land, Db.Land)
    field(:name, :string)
    field(:type, Type)
    field(:balance, :float)
    timestamps()
  end

  @required_fields [:name, :type]
  @update_fields [:player_id, :shop_id, :land_id, :name, :balance]
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
