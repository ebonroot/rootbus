# Java API

[
[TOP](../) |
[Data Structs](data-structs.md) |
[ZeroMQ Mesh](zeromq-mesh.md) |
[Java Development](java.md) |
[Elixir Development](elixir.md)
]

<< Work in progress >>

Look in [`./java`](../java)

The goal is to get a java library API that can be used in any plugin, such that
you can do things like:

```
  Rootbus.get(Rootbus.PLAYER, player_id)
  Rootbus.update(Rootbus.PLAYER, ...changes here...)

  Rootbus.list(Rootbus.SHOPS, "filter here")
```

Or whatever the equivalance will be for Java.  Perhaps the more typically java verbose:

```
  Rootbus.getPlayerWithId(player_id)
```
