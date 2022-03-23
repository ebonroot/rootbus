defmodule Rootbus.Db.Land do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  # ... what is type?
  defenum(Type, default: 0)

  typed_schema "lands" do
    belongs_to(:world, Db.World)
    field(:name, :string)
    field(:title, :string)
    field(:type, Type, default: :default)
    belongs_to(:spawn, Db.Location)
    field(:claimed_chunks)
    field(:stats)
    field(:config)
    timestamps()
  end

  @required_fields [:name, :world_id]
  @update_fields [:title, :type, :spawn_id, :claimed_chunks, :stats, :config]
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
