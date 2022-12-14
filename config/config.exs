import Config

config :fnd,
  ecto_repos: [Fnd.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :fnd, FndWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: FndWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Fnd.PubSub,
  live_view: [signing_salt: "Knydx5I4"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/* --loader:.js=jsx),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
