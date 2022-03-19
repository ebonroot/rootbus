defmodule Rootbus.Protobuf.Event.DataEntry do
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

defmodule Rootbus.Protobuf.Event do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          data: %{String.t() => Rootbus.Protobuf.KeyValue.t() | nil}
        }

  defstruct name: "",
            data: %{}

  field(:name, 1, type: :string)
  field(:data, 2, repeated: true, type: Rootbus.Protobuf.Event.DataEntry, map: true)
end
