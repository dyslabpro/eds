# Since configuration is shared in umbrella projects, this file
# should only configure the :eds_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :eds_web,
  ecto_repos: [Eds.Repo],
  generators: [context_app: :eds]

# Configures the endpoint
config :eds_web, EdsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LVVl/MYtYiZhpeQNGkoayQdQz7iY6GGVCDzVMbjln58MSSD5DTRDV1JljZFk4N/J",
  render_errors: [view: EdsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: EdsWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    facebook: {Ueberauth.Strategy.Facebook, []}
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :arc,
  storage: Arc.Storage.Local

