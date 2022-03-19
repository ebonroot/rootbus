# Root Bus — Ebon Root Minecraft Data Bus

Minecraft data schema with proper [data normalization](https://en.wikipedia.org/wiki/Database_normalization) to the third normal form,
plus protobuf structs for efficient transactions on a message bus, and a
processing engine in Elixir/erlang because it's well suited for this (which is
why it's what Discord uses on their backend).

Used in a message bus with [EbonRoot](https://ebonroot.com).

**Released under GNU Affero GPL.** *Please understand the terms of this license — notably if you run a modified version on a server and let others communicate with it, you must also publish the modified source code changes.* — Ideally we would prefer you make a public repo fork on github, and maintain your changes therein.


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

## Architecture

This system uses ZeroMQ, which, unlike other databuses (RabbitMQ, Redis), does
not require an intermediary management server.  The only system required is
the Root Bus server itself (Elixir/erlang), and configuring plugins to use this
bus vs other databases.

### Entity-Relationship Diagram

![ER Diagram](/docs/ER-diagram.png)

### Protobufs

<< more to come here on the structs >>

`Envelope` is an outer wrapper for all other types.  Everything should embed
from that point.

`Query` follows a GraphQL like approach (query or mutation).  Still in-design,
but we will need to determine how to scope this. It's not efficient to keep
the query string like in GraphQL, is there a way we can make the request in a
more focused manner.

https://developers.google.com/protocol-buffers/docs/proto3

## Java API

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

## Elixir Development

Prerequisite: Elixir and Postgres.

* Linux: install as appropriate for your platform (yum, apk, apt)
* MacOS `brew install elixir` and `brew install postgres` is sufficient
* Windows... TBD


### Compiling protobuf structs

1. install `protobuf` package for your app to get the `protoc` command.
2. install escript bits for mix, add escript to your path, and generate the models:

   ```bash
   mix escript.install hex protobuf
   export PATH=$PATH:~/.mix/escripts

   rm lib/protobuf/*
   protoc -I protobuf --elixir_out=lib/protobuf protobuf/*

   mix format
   ```

3. IMPORTANT: run `mix format` after regenerating new protobuf files, as the
   generated files do not follow format standard structure.
