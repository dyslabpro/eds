# Since configuration is shared in umbrella projects, this file
# should only configure the :eds application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# Configure your database
config :eds, Eds.Repo,
  username: "postgres",
  password: "postgres",
  database: "eds_dev_1",
  hostname: "localhost",
  pool_size: 10
