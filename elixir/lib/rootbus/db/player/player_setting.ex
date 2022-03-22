defmodule Rootbus.Db.PlayerSetting do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  # defenum(
  #   Type,
  #   healed_at: 0, # last
  #   tp_at: 1, # last
  #   tp_enabled: 2, # status
  #   tp_auto: 3, # status
  #   godmode: 4, # status
  #   muted: 5, # status
  #   muted_at: 6, # last
  #   jailed: 7, # status
  #   jailed_at: 8, # last
  #   ipaddr: 9, # info
  #   afk: 10, # status
  #   socialspy: 10, # status
  #   npc: 11, # status
  #   powertools: 12 # status
  #   afktime # info - total hours afk
  #   ontime # info - total hours online
  #   playtime # info - total hours played (ontime - afktime)
  # )

  defenum(Type, last: 0, status: 1, info: 2)

  # field(:accepting_pay, :boolean, default: false)
  # field(:baltop_exempt, :boolean, default: false)

  schema "player_settings" do
    belongs_to(:player, Db.Player)
    field(:type, Type)
    field(:name, Ecto.DangerousAtom)
    field(:int, :integer)
    field(:bool, :boolean)
    field(:str, :string)
    timestamps()
  end

  @required_fields [:player_id, :type, :name]
  @update_fields [:int, :bool, :str]
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
