# Eds
Development in progress, you can see the code in develop branch


To start your EDS server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd apps/eds_web/assets && npm install`
  * Generate example of data `mix run apps/eds/priv/repo/seeds.exs`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
Now you can visit [`localhost:4100`](http://localhost:4100) from your browser.
