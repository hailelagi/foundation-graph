import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :fnd, Fnd.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "fnd_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fnd, FndWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ASTjUyg9NcGdQN2iwhQSDCCRi60+TZ0bwLltwPVsrl+CWlQRkthmzcXWaYE5TBPw",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :fnd,
  graphql_endpoint: "https://gateway.thegraph.com/api/",
  sub_graph: "test-graph",
  key: nil,
  client_api: Fnd.Graph.ClientMock

config :fnd, Oban, testing: :inline
