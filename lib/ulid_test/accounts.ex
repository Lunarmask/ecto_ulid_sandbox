defmodule UlidTest.Accounts do
  import Ecto.Query, warn: false
  alias UlidTest.Repo

  alias UlidTest.Accounts.User

  def create_user(attrs) when is_map(attrs) do
    User.changeset(attrs)
    |> Repo.insert!()
  end

  def get_user(id), do: Repo.get(User, id)
end
