# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :bankbot, Bankbot.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "VIu5J8BDjjF1uBSeKUiGn81D3/HW0fUd8qXiiV4yk/ew//CNn4vEuWkahPPjFG0e",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Bankbot.PubSub,
           adapter: Phoenix.PubSub.PG2],
  wit_key: "B3FMD4UOBTNE4X7AIZLMUO7HY4EBXQDD",
  nexmo_key: "c71c9126",
  nexmo_secret: "256cafd12fc50eac"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
