defmodule Rootbus.Protobuf.Shop do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t()
        }

  defstruct id: ""

  field(:id, 1, type: :string)
end
