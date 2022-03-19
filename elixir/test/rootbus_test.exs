defmodule Rootbus.Test do
  use ExUnit.Case
  # alias Rootbus.Data

  # describe "Rootbus.Data.Event" do
  #   test "encodes :enriched type" do
  #     assert {:ok, _encoded_data} =
  #              Data.Event.create!(%Data.Metric{type: :enriched}, %{})
  #              |> Rootbus.Data.Event.encode()
  #   end
  #
  #   test "create/0" do
  #     ev = Data.Event.create!(%Data.Metric{}, %{})
  #     assert String.length(ev.id) == 36
  #     assert ev.ts > 1
  #     line1 = "With a 'hi, hi, ho' and a 'hi, hi, hey'"
  #     line2 = "We're hoisting the flag to be free"
  #     line3 = "We will steal the show, Jolly Rogers go"
  #     line4 = "We are wolves of the sea"
  #
  #     ev =
  #       Data.Event.create!(%Data.Log{message: line1}, %{
  #         source_id: line2,
  #         target_id: line3,
  #         meta: %{
  #           line: line4
  #         }
  #       })
  #
  #     assert String.length(ev.id) == 36
  #     assert ev.ts > 1
  #     assert ev.topic == :log
  #     assert ev.data.message == line1
  #     assert ev.source_id == line2
  #     assert ev.target_id == line3
  #     assert ev.meta.line == line4
  #   end
  # end
  #
  # describe "Rootbus.Protobuf.Event" do
  #   test "Full-cycle conversion" do
  #     source_id = "9E56D1E6-F796-4BB2-A271-0F7545B79D99"
  #
  #     ev =
  #       Data.Event.create!(
  #         %Data.Metric{
  #           measures: %{
  #             "input.power1va" => 0.3824822,
  #             "output.power1va" => 0.868281
  #           }
  #         },
  #         %{source_id: source_id}
  #       )
  #
  #     assert ev.subject == String.to_atom(source_id)
  #
  #     {:ok, bin} = Data.Event.encode(ev)
  #     assert is_binary(bin)
  #
  #     ## wait a moment so we can see if time is recorded properly
  #     # Process.sleep(1000)
  #     {:ok, decoded} = Data.Event.decode(bin)
  #     # because protobuf sets it as a string instead of nil, it'll throw the
  #     # test, so let's fiddle with it first...
  #     decoded = %Data.Event{decoded | target_id: nil}
  #     assert ev == decoded
  #   end
  # end
end
