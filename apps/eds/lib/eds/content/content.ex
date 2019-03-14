defmodule Eds.Content do
  defmacro __using__(opts) do
    quote do
      use Ecto.Schema
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      alias Eds.Repo
      alias Eds.Content.{Node, Image, Text}
      import EctoEnum

      defenum(Position, center: 0, left: 1, right: 2)

      def by_weight(query \\ __MODULE__), do: from(q in query, order_by: q.weight)

      def published(query \\ __MODULE__),
        do: from(q in query, where: q.published, where: q.published_at <= ^Timex.now())

      defp validate_position(changeset) do
        if position = get_change(changeset, :position) do
          node =
            if node_id = get_change(changeset, :node_id) do
              Node.get!(node_id)
            else
              Node.get!(changeset.data.node_id)
            end

          positions = Node.get_positions_by_layout(node.layout)

          if Enum.member?(positions, position) do
            changeset
          else
            change(changeset, position: List.first(positions))
          end
        else
          changeset
        end
      end
    end
  end
end
