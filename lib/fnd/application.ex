defmodule Fnd.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Fnd.Repo,
      FndWeb.Telemetry,
      {Phoenix.PubSub, name: Fnd.PubSub},
      FndWeb.Endpoint,
      Fnd.Cache,
      {Finch,
       name: FndFinch,
       pools: %{
         :default => [size: 10],
         "https://ipfs.io" => [size: 32, count: 8]
       }},
      {Oban, Application.fetch_env!(:fnd, Oban)}
    ]

    opts = [strategy: :one_for_one, name: Fnd.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    FndWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
