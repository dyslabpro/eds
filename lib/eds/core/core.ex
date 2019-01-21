defmodule Eds.Core do
  defmacro __using__(opts) do
    quote do
      use Ecto.Schema
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      alias Eds.Repo

      def by_weight(query \\ __MODULE__), do: from(q in query, order_by: q.weight)

      def published(query \\ __MODULE__),
        do: from(q in query, where: q.published, where: q.published_at <= ^Timex.now())
    end
  end
end
