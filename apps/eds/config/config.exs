# Since configuration is shared in umbrella projects, this file
# should only configure the :eds application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :eds,
  ecto_repos: [Eds.Repo]

import_config "#{Mix.env()}.exs"

config :arc,
  storage: Arc.Storage.Local
