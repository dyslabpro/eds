defmodule Eds.Content.Text do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eds.Content.{Node, Text}
  alias Eds.{Repo}
  import Ecto.Query
  use Eds.Content

  schema "texts" do
    field(:title, :string)
    field(:position, Position)
    field(:text, :string)
    field(:weight, :integer)
    belongs_to(:node, Node)

    timestamps()
  end

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

  def delete(%Text{} = text) do
    Repo.delete(text)
  end

  @doc false
  def changeset(%Text{} = text, attrs) do
    text
    |> cast(attrs, [:title, :node_id, :text, :weight, :position])
    |> validate_required([:text, :node_id, :position])
    |> validate_position()
  end
end
