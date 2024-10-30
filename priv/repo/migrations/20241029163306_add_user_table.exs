defmodule UlidTest.Repo.Migrations.AddUserTable do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS cube;", "DROP EXTENSION IF EXISTS cube;"

    create table("users", primary_key: false) do
      add :id, :cube, primary_key: true, null: false
      add :name, :string, null: false, size: 40

      timestamps()
    end
  end
end
