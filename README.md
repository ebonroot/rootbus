![rootbus](docs/databus.jpg)

# Root Bus — Ebon Root Minecraft Data Bus

Minecraft data schema with proper [data normalization](https://en.wikipedia.org/wiki/Database_normalization) to the third normal form,
plus protobuf structs for efficient transactions on a message bus, and a
processing engine in Elixir/erlang because it's well suited for this (which is
why it's what Discord uses on their backend).

Used in a message bus with [EbonRoot](https://ebonroot.com).

**Released under GNU Affero GPL.** *Please understand the terms of this license — notably if you run a modified version on a server and let others communicate with it, you must also publish the modified source code changes.* — Ideally we would prefer you make a public repo fork on github, and maintain your changes therein.

* [Data Structs](docs/data-structs.md)
* [Zero MQ Mesh](docs/zeromq-mesh.md)
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
