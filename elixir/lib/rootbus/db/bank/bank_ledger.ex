defmodule Rootbus.Db.BankLedger do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  # double-column... two rows for each transaction, one adding, one subtracting
  typed_schema "bank_ledgers" do
    belongs_to(:player, Db.Player)
    belongs_to(:account, Db.BankAccount)
    field(:amount, :float)
    field(:memo, :string)
    timestamps()
  end

  @required_fields [:player_id, :account_id, :amount, :memo]
  @update_fields []
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
