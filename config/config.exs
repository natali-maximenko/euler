# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :euler,
  ecto_repos: [Euler.Repo]

# Configures the endpoint
config :euler, EulerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ctl4s2NM/8ARBJLSVx/FxVjUCRPXpuxp45QJTj4FNt2NSvF1qZ+mfLYLGN1CaeZ3",
  render_errors: [view: EulerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Euler.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "FeocdBbB"]

config :euler, Euler.Administration.Accounts.Guardian,
  issuer: "euler",
  secret_key: "en5D08DeqA2Ip+KryAUiRADAZd5I9I98r0QEiUOXRmqBPBul4rSZZrDX7kEg6cbo"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
