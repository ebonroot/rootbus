defmodule Rootbus.Db.TeamMember do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  defenum(Type, owner: 0, member: 1)

  typed_schema "team_members" do
    belongs_to(:player, Db.Player)
    belongs_to(:team, Db.Team)
    field(:type, Type, default: :member)
    timestamps()
  end

  @required_fields [:player_id, :team_id]
  @update_fields [:type]
  @create_fields @required_fields ++ @update_fields

  def validate(chgset) do
    chgset
    |> validate_required(@required_fields)
  end

  @doc """
  Build a changeset for creating a new TeamMember.
  """
  def build(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, @create_fields)
    |> validate
  end

  @doc """
  Changeset for performing updates to a TeamMember.
  """
  def changeset(item, attrs) do
    item
    |> cast(attrs, @update_fields)
    |> validate
  end
end
