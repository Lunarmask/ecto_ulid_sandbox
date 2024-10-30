defmodule UlidTest.Accounts.User do
  use UlidTest.Schema

  @primary_key {:id, Cubecto.Type, autogenerate: true}
  @foreign_key_type Cubecto.Type
  schema "users" do
    field :name, :string

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
