# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sauce_test,
  ecto_repos: [SauceTest.Repo]

# Configures the endpoint
config :sauce_test, SauceTestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NMW9Yodf1B14XZnU21xlH3csKha7aHGX7UsJUxOOAAd6iNY7PqVOGNDgLw2ysVOh",
  render_errors: [view: SauceTestWeb.ErrorView, accepts: ~w(json json-api), layout: false],
  pubsub_server: SauceTest.PubSub,
  live_view: [signing_salt: "hQlEqoqj"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :format_encoders, "json-api": Jason

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
