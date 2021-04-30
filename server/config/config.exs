# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :server,
  ecto_repos: [Server.Repo]

# Configures the endpoint
config :server, ServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "o8My9qu7CnJeSB3xEKBMyqEhjSaXqTK8YFyHkj9WW/z5Ci1si1b3s+7XHQRKeAI8",
  render_errors: [view: ServerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Server.PubSub,
  live_view: [signing_salt: "219jghgq"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian config
config :server, Server.Guardian,
       issuer: "server",
       secret_key: "2HfpOjzghCnZZpC1PHyaUppBYZV093cWzRaIjzZdg5x7Gx+lI475Sxbzd7CUsb/m"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
