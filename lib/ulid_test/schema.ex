defmodule UlidTest.Schema do
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      @primary_key {:id, Ecto.ULID, autogenerate: true}
      @foreign_key_type Ecto.ULID
    end
  end
end
