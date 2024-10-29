defmodule UlidTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      UlidTestWeb.Telemetry,
      UlidTest.Repo,
      {DNSCluster, query: Application.get_env(:ulid_test, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: UlidTest.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: UlidTest.Finch},
      # Start a worker by calling: UlidTest.Worker.start_link(arg)
      # {UlidTest.Worker, arg},
      # Start to serve requests, typically the last entry
      UlidTestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UlidTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UlidTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
