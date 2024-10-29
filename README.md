# Ecto Ulid Sandbox

This sandbox application is designed to showcase [**ULID**](https://github.com/ulid/spec) style UUIDs being used as the
Primary Table Key within a phoenix application. It's as barebones as can-be, adding just what's needed on top of a
`phx.new` application.

It uses this awesome PostgreSQL extension in order to accomplish this on the database side:

[**[ github: andrielfn / pg-ulid ]**](https://github.com/andrielfn/pg-ulid)

Simply do the following after you have a working Postgres installation:

```
  git clone https://github.com/andrielfn/pg-ulid.git
  cd pg-ulid
  make install
```

Afterward start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## How it works

The `pg-ulid` extension provides a unique field type of `ulid` and is specified as-such when the database provides the data to the
application.

The `pg-ulid` extension stores the ULID identifier in the database as a binary data (BYTEA) field.

The ULID is cast into a string when being displayed or queried from the database.

The Ecto.ULID module handles the ulid field data as a String, as that's the format provided by the database.

The Ecto.ULID module auto-generates a valid ULID upon persisting new %Structs{}. But does NOT do so when using
Repo functions that bypass callbacks such as `Repo.insert_all/3`.

<hr>

Various resources were used as inspiration and research, credit goes to them.

- https://github.com/ulid/spec -- (ULID Specification)

- https://github.com/andrielfn/pg-ulid -- (PostgreSQL ULID Extension)

- https://github.com/ibarchenkov/cubecto -- (Postgrex.Extension -- Used as reference to make one for the pg-ulid extension)

- https://github.com/woylie/ecto_ulid -- (Elixir Ecto Type -- needed to be modified to be used with the pg-ulid extension)

