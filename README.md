![rootbus](docs/databus.jpg)

# Root Bus — Ebon Root Minecraft Data Bus

Minecraft data schema with proper [data normalization](https://en.wikipedia.org/wiki/Database_normalization) to the third normal form,
plus protobuf structs for efficient transactions on a message bus, and a
processing engine in Elixir/erlang because it's well suited for this (which is
why it's what Discord uses on their backend).

Used in a message bus with [EbonRoot](https://ebonroot.com).

**Released under GNU Affero GPL.** *Please understand the unique terms of this OSS license — notably if you run a modified version on a public server, you must also publish the modified source code changes.* — Ideally we would prefer you make a public repo fork on github, and maintain your changes therein.

* [Data Structs](docs/data-structs.md)
* [ZeroMQ Mesh](docs/zeromq-mesh.md)
* [Java Development](docs/java.md)
* [Elixir Development](docs/elixir.md)

## Why

A databus is what game engines working at scale use in any modern MMO.  They
facilitate multi-server synchronization without the common challenges of
concurrency across discrete systems.  They are a good way to deal with
asyncronous changes while also keeping the benefits of [ACID storage](https://en.wikipedia.org/wiki/ACID).

However, doing a databus properly requires a good data schema.

Additionally, Serializing binary java structs into a SQL table row is
inefficient, especially when it's base64 encoded, and serializing json
structs is also inefficient — yet this is commonly what most of the current
plugins are doing, when using a database.  They also don't take advantage
of relationships, and are usually only in the first normal form, if normalized
at all.

Comparative benchmarks to be published over time.

By centralizing messages into a databus it also allows a single location
to process some meta-game logic (such as buying things from shops, or
levelling up ranks), so it is no longer decentralized and out-of-sync, across
many disparate servers.


## How to use in a Plugin

<< WIP: this text is our goal, not yet fully implemented.  See also: [Data Structs](docs/data-structs.md) >>

Your plugin's data layer just needs to import the Rootbus java API, have a
Rootbus core server setup, then you can connect to the bus with the following.  See [ZeroMQ Mesh](docs/zeromq-mesh.md) for more about the
message bus mesh.

```java
// address of one core server, the rest come automatically afterwards
Rootbus.Mesh.join("tcp://ip:4040");
```

After this you can use any of the rootbus data types, along with a powerful query structure following [GraphQL standard](https://graphql.org):

```java
// TBD how do other java Graphql interfaces handle varibles?
Rootbus.query("""
getShops($world: String) {
  getShops(world: $world) {
    id
    location { worldId, x, y, z }
    itemType
    buyPrice
    sellPrice
  }
}""");
```

Or just request/update a single item:

```java
Rootbus.Db.Player.get(id, Rootbus.Db.Player.ALL); // everything
Rootbus.Db.Player.get(id, Rootbus.Db.Player.HELD_INVENTORY);

Rootbus.Db.PlayerSheet.get(id, Rootbus.Db.PlayerSheet.HEALTH);

// or update
Rootbus.Db.PlayerSheet.update(id, Rootbus.Db.PlayerSheet.HEALTH, 120);
```

Forwarding an event:

(note: how do people deal with java not having free form dicts??  The following example isn't correctly java, so we'd have to get it dialed in for java).

```java
Rootbus.Message.Event.sendToRole("PROXY",
  new Event("PlayerTeleport",
    server="server-id",
    world="world-id",
    location="x,y,z")
  );
```

Following the above event the proxy would move the player to the new server, and then send an event to that server `PlayerTeleportArrival` which the server
would receive and handle the rest of the movement.
