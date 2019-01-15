defmodule Eds.Content.Text do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eds.Content.{Node, Text}
  alias Eds.{Repo}
  import Ecto.Query

  schema "texts" do
    field(:title, :string)
    field(:text, :string)
    field(:weight, :integer)
    belongs_to(:node, Node)

    timestamps()
  end

  def by_weight(query \\ __MODULE__), do: from(q in query, order_by: q.weight)

  def create(attrs \\ %{}) do
    %Text{}
    |> Text.changeset(attrs)
    |> Repo.insert()
  end

  def change(%Text{} = text) do
    Text.changeset(text, %{})
  end

  def get!(id), do: Repo.get!(Text, id)

  def update(%Text{} = text, attrs) do
    text
    |> Text.changeset(attrs)
    |> Repo.update()
  end

  @doc false
  def changeset(%Text{} = text, attrs) do
    text
    |> cast(attrs, [:title, :node_id, :text, :weight])
    |> validate_required([:text])
  end
end
