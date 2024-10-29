defmodule UlidTest.Accounts.User do
  use UlidTest.Schema

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
