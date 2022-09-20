defmodule Fnd.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Fnd.Repo,
      # Start the Telemetry supervisor
      FndWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Fnd.PubSub},
      # Start the Endpoint (http/https)
      FndWeb.Endpoint
      # Start a worker by calling: Fnd.Worker.start_link(arg)
      # {Fnd.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Fnd.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FndWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
