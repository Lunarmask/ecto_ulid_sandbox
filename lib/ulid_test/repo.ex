defmodule UlidTest.Repo do
  use Ecto.Repo,
    otp_app: :ulid_test,
    adapter: Ecto.Adapters.Postgres
end
