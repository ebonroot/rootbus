defmodule Rootbus.Protobuf.Record.SchemaType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :player

  field(:player, 0)
end

defmodule Rootbus.Protobuf.Record.DataEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: Rootbus.Protobuf.KeyValue.t() | nil
        }

  defstruct key: "",
            value: nil

  field(:key, 1, type: :string)
  field(:value, 2, type: Rootbus.Protobuf.KeyValue)
end

defmodule Rootbus.Protobuf.Record do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          schema: Rootbus.Protobuf.Record.SchemaType.t(),
          data: %{String.t() => Rootbus.Protobuf.KeyValue.t() | nil}
        }

  defstruct schema: :player,
            data: %{}

  field(:schema, 1, type: Rootbus.Protobuf.Record.SchemaType, enum: true)
  field(:data, 4, repeated: true, type: Rootbus.Protobuf.Record.DataEntry, map: true)
end
