defmodule Rootbus.Db.PlayerSetting do
  use Rootbus.Ecto

  @timestamps_opts [type: :utc_datetime]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  defenum(
    Type,
    healed_at: 0,
    tp_at: 1,
    tp_enabled: 2,
    tp_auto: 3,
    godmode: 4,
    muted: 5,
    muted_at: 6,
    jailed: 7,
    jailed_at: 8,
    ipaddr: 9,
    afk: 10,
    socialspy: 10,
    npc: 11,
    powertools: 12
  )

  # field(:accepting_pay, :boolean, default: false)
  # field(:baltop_exempt, :boolean, default: false)

  schema "player_settings" do
    belongs_to(:player, Db.Player)
    field(:type, Type)
    field(:int, :integer)
    field(:bool, :boolean)
    field(:str, :string)
    # field(:healed_at, :integer, default: 0)
    # field(:tp_at, :integer, default: 0)
    # field(:tp_enabled, :boolean, default: false)
    # field(:tp_auto, :boolean, default: false)
    # field(:godmode, :boolean, default: false)
    # field(:muted, :boolean, default: false)
    # field(:muted_at, :integer, default: 0)
    # field(:jailed, :boolean, default: false)
    # field(:jailed_at, :integer, default: 0)
    # field(:ipaddr, :string, default: "")
    # field(:afk, :bolean, default: false)
    # field(:socialspy, :bolean, default: false)
    # field(:npc, :bolean, default: false)
    # field(:powertools, :bolean, default: false)
    timestamps()
  end

  @required_fields [:player_id, :type]
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
