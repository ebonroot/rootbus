defmodule Rootbus.Protobuf.KeyValue do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value:
            {:string, String.t()}
            | {:double, float | :infinity | :negative_infinity | :nan}
            | {:int64, integer}
            | {:bytes, binary}
            | {:map, Rootbus.Protobuf.Values.t() | nil}
            | {:list, Rootbus.Protobuf.Multiple.t() | nil}
            | {:bool, boolean}
        }

  defstruct value: nil

  oneof(:value, 0)

  field(:string, 1, type: :string, oneof: 0)
  field(:double, 2, type: :double, oneof: 0)
  field(:int64, 3, type: :sint64, oneof: 0)
  field(:bytes, 4, type: :bytes, oneof: 0)
  field(:map, 6, type: Rootbus.Protobuf.Values, oneof: 0)
  field(:list, 7, type: Rootbus.Protobuf.Multiple, oneof: 0)
  field(:bool, 8, type: :bool, oneof: 0)
end

defmodule Rootbus.Protobuf.Multiple do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          values: [Rootbus.Protobuf.KeyValue.t()]
        }

  defstruct values: []

  field(:values, 1, repeated: true, type: Rootbus.Protobuf.KeyValue)
end

defmodule Rootbus.Protobuf.Values.ValuesEntry do
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

defmodule Rootbus.Protobuf.Values do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          values: %{String.t() => Rootbus.Protobuf.KeyValue.t() | nil}
        }

  defstruct values: %{}

  field(:values, 6, repeated: true, type: Rootbus.Protobuf.Values.ValuesEntry, map: true)
end
