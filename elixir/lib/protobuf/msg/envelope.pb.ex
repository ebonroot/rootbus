defmodule Rootbus.Protobuf.Envelope do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          topic:
            {:event, Rootbus.Protobuf.Event.t() | nil}
            | {:request, Rootbus.Protobuf.Request.t() | nil}
            | {:record, Rootbus.Protobuf.Record.t() | nil},
          id: String.t(),
          ts: non_neg_integer,
          source_id: String.t(),
          target_id: String.t(),
          parent_id: String.t()
        }

  defstruct topic: nil,
            id: "",
            ts: 0,
            source_id: "",
            target_id: "",
            parent_id: ""

  oneof(:topic, 0)

  field(:id, 1, type: :string)
  field(:ts, 2, type: :uint64)
  field(:source_id, 3, type: :string, json_name: "sourceId")
  field(:target_id, 4, type: :string, json_name: "targetId")
  field(:parent_id, 5, type: :string, json_name: "parentId")
  field(:event, 6, type: Rootbus.Protobuf.Event, oneof: 0)
  field(:request, 7, type: Rootbus.Protobuf.Request, oneof: 0)
  field(:record, 8, type: Rootbus.Protobuf.Record, oneof: 0)
end
