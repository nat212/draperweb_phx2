defmodule DraperWebPhx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DraperWebPhxWeb.Telemetry,
      DraperWebPhx.Repo,
      {DNSCluster, query: Application.get_env(:draperweb_phx, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DraperWebPhx.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DraperWebPhx.Finch},
      # Start a worker by calling: DraperWebPhx.Worker.start_link(arg)
      # {DraperWebPhx.Worker, arg},
      # Start to serve requests, typically the last entry
      DraperWebPhxWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DraperWebPhx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DraperWebPhxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
