use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :bankbot, Bankbot.Endpoint,
  secret_key_base: "RTO9mVGIkrmCyvvmpmXpd5JO9qeFyxWtE9amG1/r6ZziDmGvGGLal7n/B8gp8GjV"

# Configure your database
config :bankbot, Bankbot.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "bankbot_prod",
  pool_size: 20
