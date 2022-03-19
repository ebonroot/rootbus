defmodule Rootbus.Protobuf.Request.QueryType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :create | :read | :update | :delete

  field(:create, 0)
  field(:read, 1)
  field(:update, 2)
  field(:delete, 3)
end

defmodule Rootbus.Protobuf.Request.VariablesEntry do
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

defmodule Rootbus.Protobuf.Request do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          type: Rootbus.Protobuf.Request.QueryType.t(),
          query: String.t(),
          variables: %{String.t() => Rootbus.Protobuf.KeyValue.t() | nil}
        }

  defstruct type: :create,
            query: "",
            variables: %{}

  field(:type, 1, type: Rootbus.Protobuf.Request.QueryType, enum: true)
  field(:query, 2, type: :string)
  field(:variables, 3, repeated: true, type: Rootbus.Protobuf.Request.VariablesEntry, map: true)
end
