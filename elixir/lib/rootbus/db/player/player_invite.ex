defmodule Rootbus.Db.PlayerInvite do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  defenum(Type, land: 0, team: 1)

  typed_schema "player_invites" do
    belongs_to(:player, Db.Player)
    field(:type, Type, default: :land)
    field(:ref_id, :binary_id)
    field(:expires, :utc_datetime)
    field(:meta, :map)
    timestamps()
  end

  @required_fields [:player_id, :type, :ref_id, :expires]
  @update_fields []
  @create_fields @required_fields ++ @update_fields

  def validate(chgset) do
    chgset
    |> validate_required(@required_fields)
  end

  @doc """
  Build a changeset for creating a new PlayerInvite.
  """
  def build(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, @create_fields)
    |> validate
  end

  @doc """
  Changeset for performing updates to a PlayerInvite.
  """
  def changeset(item, attrs) do
    item
    |> cast(attrs, @update_fields)
    |> validate
  end
end
