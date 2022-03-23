defmodule Rootbus.Db.User do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  defenum(Type,
    unknown: 0,
    identity: 1,
    identity_signedout: 3,
    authed: 2,
    hidden: 4,
    disabled: 200
  )

  typed_schema "users" do
    field(:name, :string)
    field(:type, Type, default: :unknown)
    timestamps()
  end

  @required_fields [:name, :type]
  @update_fields [:name, :type]
  @create_fields @required_fields ++ @update_fields

  def validate(chgset) do
    chgset
    |> validate_required(@required_fields)
  end

  @doc """
  Build a changeset for creating a new user.
  """
  def build(params \\ %{}) do
    %__MODULE__{}
    |> cast(params, @create_fields)
    |> validate
  end

  @doc """
  Changeset for performing updates to a user.
  """
  def changeset(item, attrs) do
    item
    |> cast(attrs, @update_fields)
    |> validate
  end
end
