# Data Structures

[
[TOP](../) |
[Data Structs](data-structs.md) |
[Zero MQ Mesh](zeromq-mesh.md) |
[Java Development](java.md) |
[Elixir Development](elixir.md)
]

## Entity-Relationship Diagram

This ER diagram is for the data within the database.  You can see the [table](../elixir/rootbus/priv/repo/migrations) and [model](../elixir/rootbus/lib/rootbus/db) and definitions as well.

![ER Diagram](/docs/ER-diagram.webp)

## Protobufs

Look in [`./protobuf`](../protobuf)

<< more to come here on the structs >>

`Envelope` is an outer wrapper for all other types.  Everything should embed
from that point.

`Query` follows a GraphQL like approach (query or mutation).  Still in-design,
but we will need to determine how to scope this. It's not efficient to keep
the query string like in GraphQL, is there a way we can make the request in a
more focused manner.

https://developers.google.com/protocol-buffers/docs/proto3
