defmodule Eds.Content.Image do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias Eds.Content.{Node, Image}
  alias Eds.{Repo}
  import Ecto.Query
  use Eds.Content



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

  def delete(%Image{} = image) do
    Repo.delete(image)
  end

  @doc false
  def changeset(%Image{} = image, attrs) do
    image
    |> cast(attrs, [:title, :node_id, :weight, :position])
    |> validate_required([:node_id])
    |> validate_position()
  end

  def image_changeset(image, attrs) do
    image |> cast_attachments(attrs, [:image])
  end

end
