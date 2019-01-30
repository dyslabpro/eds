defmodule Eds.Content.Node do
  use Ecto.Schema
  import EctoEnum
  import Ecto.Changeset
  alias Eds.Core.{Chapter, Course, Section}
  alias Eds.Content.{Node, Text, Image}
  alias Eds.{Repo}
  import Ecto.Query

  defenum Layout, default_1_column: 0, default_2_columns_50_50: 1, default_2_columns_25_75: 2, default_2_columns_75_35: 3, default_3_columns_33_33_33: 4


  schema "nodes" do
    field(:title, :string)
    field(:text, :string)
    field(:layout, Layout)
    field(:weight, :integer)
    field(:published, :boolean, default: false)
    field(:published_at, :utc_datetime)
    belongs_to(:course, Course)
    belongs_to(:section, Section)
    belongs_to(:chapter, Chapter)
    has_many(:texts, Text, on_delete: :delete_all)
    has_many(:images, Image, on_delete: :delete_all)

    timestamps()
  end

  def preload_content(node) do
    node
    |> Repo.preload(:texts)
  end

  def create(attrs \\ %{}) do
    %Node{}
    |> Node.changeset(attrs)
    |> Repo.insert()
  end

  def change(%Node{} = node) do
    Node.changeset(node, %{})
  end

  def get!(id), do: Repo.get!(Node, id)

  def update(%Node{} = node, attrs) do
    node
    |> Node.changeset(attrs)
    |> Repo.update()
  end

  def only_course(query \\ __MODULE__),
    do: from(q in query, where: is_nil(q.section_id) and is_nil(q.chapter_id))

  def only_chapter(query \\ __MODULE__), do: from(q in query, where: is_nil(q.section_id))

  @doc false
  def changeset(%Node{} = node, attrs) do
    node
    |> cast(attrs, [
      :title,
      :course_id,
      :section_id,
      :chapter_id,
      :text,
      :published,
      :published_at,
      :weight
    ])
    |> validate_required([:title])
  end
end
