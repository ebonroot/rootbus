# Java API

[
[TOP](../README.md) |
[Data Structs](docs/data-structs.md) |
[Zero MQ Mesh](docs/zeromq-mesh.md) |
[Java Development](docs/java.md) |
[Elixir Development](docs/elixir.md)
]

<< Work in progress >>

Look in `./java`

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
