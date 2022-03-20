# Data Structures

[
[TOP](../README.md) |
[Data Structs](docs/data-structs.md) |
[Zero MQ Mesh](docs/zeromq-mesh.md) |
[Java Development](docs/java.md) |
[Elixir Development](docs/elixir.md)
]

## Entity-Relationship Diagram

![ER Diagram](/docs/ER-diagram.png)

## Protobufs

Look in `./protobuf`

<< more to come here on the structs >>

`Envelope` is an outer wrapper for all other types.  Everything should embed
from that point.

`Query` follows a GraphQL like approach (query or mutation).  Still in-design,
but we will need to determine how to scope this. It's not efficient to keep
the query string like in GraphQL, is there a way we can make the request in a
more focused manner.

https://developers.google.com/protocol-buffers/docs/proto3
