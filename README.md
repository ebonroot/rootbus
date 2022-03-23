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
Rootbus.join("tcp://ip:4040");
```

Query "Shops" and get a list of Shops matching server/world.  Third argument
specifies which properties to pull.

```java
import com.ebonroot.rootbus;
import org.bukkit.World;

public class ShopData {
  public void list(String serverId, String worldId) {
    new HashMap<String, Rootbus.Shop> = shops;
    Rootbus.Shop.query(
      // keyword map of query args — get a list of all Shops for this world
      ImmutableMap.of(
        "serverId", serverId,
        "worldId", worldId
      ),

      // list of values to return
      ["id", "itemType", "location.x", "location.y", "location.z"],

      // callback to handle result after it is received
      (Rootbus.Record result) -> {
        if (result.success) {
          HashMap<String, Rootbus.Shop> shops = new HashMap<String, Rootbus.Shop>();
          for (Rootbus.Shop shop : result.values) {
            List list = shops.get(shop.itemType)
            if (list == null) {
              list = new List();
            }
            shops.put(shop.itemType, list.append(shop));
          }
          // update local shops cache.
          EzShops.update(shops);
        }
      })
  }
}
```

Adding a new shop:

```java
import com.ebonroot.Rootbus;
import org.bukkit.World;

public class ShopData {
  public create(String ownerId, String serverId, String worldId, double x, double y, double z, String itemType) {
    Rootbus.Shop.update(
      // keyvalue map of query args
      ImmutableMap.of(
        "itemType", itemType,
        "playerId", ownerId,
        "serverId", serverId,
        "worldId", worldId,
        "x", x, "y", y, "z", z
      ),
      // list of values to return
      ["id", "itemType", "location.x", "location.y", "location.z"],
      // callback to handle result after it is received
      (Rootbus.Record result) -> {
        if (result.success) {
          EzShops.addShop(result.value);
        }
      });
  }
}
```

Forwarding a PlayerLoginEvent:

```java
public void onJoin(final PlayerLoginEvent ev) {
  Rootbus.Event.send("PlayerLogin", ImmutableMap.of("playerId", ev.target.getUniqueId()));
}
```
