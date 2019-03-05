defmodule Eds.Repo do
  use Ecto.Repo,
    otp_app: :eds,
    adapter: Ecto.Adapters.Postgres
end
