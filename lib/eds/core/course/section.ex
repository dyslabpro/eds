defmodule Eds.Core.Section do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eds.Core.{Section, Chapter}
  alias Eds.Content.{Node, Text}
  alias Eds.{Repo}
  use Eds.Core

  schema "sections" do
    field(:title, :string)
    field(:weight, :integer)
    field(:published, :boolean, default: false)
    field(:published_at, :utc_datetime)
    belongs_to(:chapter, Chapter)
    has_many(:nodes, Node, on_delete: :delete_all)

    timestamps()
  end

  def preload_nodes(section) do
    section
    |> Repo.preload(nodes: [texts: Text.by_weight()])
  end

  def get_section_with_parent(id) do
    Repo.get!(Section, id) |> Repo.preload(chapter: :course)
  end

  def get_prev_section(section, sections) do
    index =
      sections
      |> Enum.find_index(fn x -> x.id == section.id end)

    if(index != 0) do
      Enum.at(sections, index - 1)
    else
      nil
    end
  end

  def get_next_section(section, sections) do
    index =
      sections
      |> Enum.find_index(fn x -> x.id == section.id end)

    Enum.at(sections, index + 1)
  end

  def list_sections do
    Repo.all(Section)
  end

  def get_section!(id), do: Repo.get!(Section, id)

  def create_section(attrs \\ %{}) do
    %Section{}
    |> Section.changeset(attrs)
    |> Repo.insert()
  end

  def update_section(%Section{} = section, attrs) do
    section
    |> Section.changeset(attrs)
    |> Repo.update()
  end

  def delete_section(%Section{} = section) do
    Repo.delete(section)
  end

  def change_section(%Section{} = section) do
    Section.changeset(section, %{})
  end

  @doc false
  def changeset(%Section{} = section, attrs) do
    section
    |> cast(attrs, [:title, :chapter_id, :published, :published_at, :weight])
    |> validate_required([:title])
  end
end
