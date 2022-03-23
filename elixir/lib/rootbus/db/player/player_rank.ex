defmodule Rootbus.Db.PlayerRank do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  typed_schema "player_ranks" do
    belongs_to(:player, Db.Player)
    belongs_to(:rank, Db.PlayerTrackRank)
    belongs_to(:track, Db.PlayerTrack)
    field(:meta, :map, default: %{})
    timestamps()
  end

  @required_fields [:player_id, :rank_id, :track_id]
  @update_fields [:rank_id, :meta]
  @create_fields @required_fields ++ @update_fields

  def validate(chgset) do
    chgset
    |> validate_required(@required_fields)
  end

  @doc """
  Build a changeset for creating a new PlayerRank.
  """
  def build(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, @create_fields)
    |> validate
  end

  @doc """
  Changeset for performing updates to a PlayerRank.
  """
  def changeset(item, attrs) do
    item
    |> cast(attrs, @update_fields)
    |> validate
  end
end
