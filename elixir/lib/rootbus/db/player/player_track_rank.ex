defmodule Rootbus.Db.PlayerTrackRank do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "player_track_ranks" do
    belongs_to(:track, Db.PlayerTrack)
    field(:name, :string)
    field(:level, :integer)
  end

  @required_fields [:track_id, :name, :level]
  @update_fields [:track_id, :name, :level]
  @create_fields @required_fields ++ @update_fields

  def validate(chgset) do
    chgset
    |> validate_required(@required_fields)
  end

  @doc """
  Build a changeset for creating a new PlayerTrackRank.
  """
  def build(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, @create_fields)
    |> validate
  end

  @doc """
  Changeset for performing updates to a PlayerTrackRank.
  """
  def changeset(item, attrs) do
    item
    |> cast(attrs, @update_fields)
    |> validate
  end
end
