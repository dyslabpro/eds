defmodule Eds.Content.Image do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias Eds.Content.{Node, Image}
  alias Eds.{Repo}
  import Ecto.Query
  import EctoEnum
  use Eds.Core

  defenum Position, center: 0, left: 1, right: 2

  schema "images" do
    field(:title, :string)
    field(:position, Position)
    field :image, Eds.Image.Type
    field(:weight, :integer)
    belongs_to(:node, Node)

    timestamps()
  end

  def create(attrs \\ %{}) do
    %Image{}
    |> Image.changeset(attrs)
    |> Repo.insert()
  end

  def change(%Image{} = text) do
    Image.changeset(text, %{})
  end

  def get!(id), do: Repo.get!(Image, id)

  def update(%Image{} = text, attrs) do
    text
    |> Image.changeset(attrs)
    |> Repo.update()
  end

  @doc false
  def changeset(%Image{} = image, attrs) do
    image
    |> cast(attrs, [:title, :node_id, :weight, :position])
    |> validate_required([:node_id])
  end

  def image_changeset(image, attrs) do
    image |> cast_attachments(attrs, [:image])
  end

end
