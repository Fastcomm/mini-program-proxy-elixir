# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mini_program_proxy_elixir,
  proxy_url: "https://services-api-stage.ttrumpet.com" #"${PROXY_PATH}"

# Configures the endpoint
config :mini_program_proxy_elixir, MiniProgramProxyElixirWeb.Endpoint,
  http: [port: 6000],
  secret_key_base: "qX6d1P/GpGHOoPSEhoJOiyfVw5cb5SnzVVJiJU/6lQEGLFMlBsvij2YyL8XXnrvM",
  render_errors: [view: MiniProgramProxyElixirWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MiniProgramProxyElixir.PubSub,
  live_view: [signing_salt: "sEIjqlWo"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
