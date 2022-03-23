defmodule Rootbus.Db.Team do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  defenum(Type, persistent: 0, session: 1)

  typed_schema "teams" do
    field(:type, Type, default: 0)
    field(:name, :string)
    field(:meta, :map)
    timestamps()
  end

  @required_fields [:type]
  @update_fields [:name, :meta, :type]
  @create_fields @required_fields ++ @update_fields

  def validate(chgset) do
    chgset
    |> validate_required(@required_fields)
  end

  @doc """
  Build a changeset for creating a new Team.
  """
  def build(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, @create_fields)
    |> validate
  end

  @doc """
  Changeset for performing updates to a Team.
  """
  def changeset(item, attrs) do
    item
    |> cast(attrs, @update_fields)
    |> validate
  end
end
