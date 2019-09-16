# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :app,
  namespace: Dashboard,
  ecto_repos: [Dashboard.Repo]

config :cors_plug,
  origin: "*",
  max_age: 86400,
  methods: ["GET", "POST", "DELETE", "PUT"]

# Configures the endpoint
config :app, DashboardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pVE6inPpqESlNF6HZEKVpEte0jdfca4E5djNe3QqH62CwlhuYGvG0+BzgAz48SZ/",
  render_errors: [view: DashboardWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Dashboard.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
