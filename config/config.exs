# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hosp,
  ecto_repos: [Hosp.Repo]

# Configures the endpoint
config :hosp, HospWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mXwhWMbhhp3+ke7KkKKIEBUDgFutvClXv0WtFxLFeIfswnPeT6fhpg592hCzOwbn",
  render_errors: [view: HospWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Hosp.PubSub,
  live_view: [signing_salt: "XhdxST/l"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Configures Guardian
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Hosp",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: "CIjVqmH/ES+bRy9AU1pO+xVCJLzGucT3CoSQJP7bP/YVyy23OYJqDYYTo9RKhAZ6", # generated through mix gen.secret
  serializer: Hosp.GuardianSerializer
