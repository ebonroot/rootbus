defmodule Rootbus.Db.PlayerLog do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  defenum(Actions, login: 0, logout: 1)

  typed_schema "player_logs" do
    belongs_to(:player, Db.Player)
    field(:action, Actions)
    field(:ipaddr, :string, default: "")
    timestamps()
  end

  @required_fields [:player_id, :action, :ipaddr]
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
