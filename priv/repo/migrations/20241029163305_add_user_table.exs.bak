defmodule UlidTest.Repo.Migrations.AddUserTable do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS pgcrypto;", "DROP FUNCTION IF EXISTS pgcrypto;"
    execute "CREATE EXTENSION IF NOT EXISTS ulid;", "DROP EXTENSION IF EXISTS ulid;"

    create table("users", primary_key: false) do
      add :id, :ulid, primary_key: true, null: false, default: fragment("gen_ulid()")
      add :name, :string, null: false, size: 40

      timestamps()
    end
  end
end
