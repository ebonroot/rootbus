# Elixir Development

[
[TOP](../README.md) |
[Data Structs](docs/data-structs.md) |
[Zero MQ Mesh](docs/zeromq-mesh.md) |
[Java Development](docs/java.md) |
[Elixir Development](docs/elixir.md)
]

Look in `./elixir`

Prerequisite: Elixir and Postgres.

* Linux: install as appropriate for your platform (yum, apk, apt)
* MacOS `brew install elixir` and `brew install postgres` is sufficient
* Windows... TBD

## Compiling protobuf structs

1. install `protobuf` package for your app to get the `protoc` command.
2. install escript bits for mix, add escript to your path, and generate the models:

   ```bash
   mix escript.install hex protobuf
   export PATH=$PATH:~/.mix/escripts

   rm lib/protobuf/*
   protoc -I ../protobuf --elixir_out=lib/protobuf ../protobuf/*/*.proto

   mix format
   ```

3. IMPORTANT: run `mix format` after regenerating new protobuf files, as the
   generated files do not follow format standard structure.
