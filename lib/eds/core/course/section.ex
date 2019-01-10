defmodule Eds.Core.Section do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eds.Core.{Section, Chapter}
  alias Eds.Content.{Node, Text}
  alias Eds.{Repo}

  schema "sections" do
    field(:title, :string)
    field(:published, :boolean, default: false)
    field(:published_at, :utc_datetime)
    belongs_to(:chapter, Chapter)
    has_many(:nodes, Node, on_delete: :delete_all)

    timestamps()
  end

  @doc false
  def changeset(%Section{} = section, attrs) do
    section
    |> cast(attrs, [:title, :chapter_id, :published, :published_at])
    |> validate_required([:title])
  end

  def preload_nodes(section) do
    section
    |> Repo.preload(nodes: [texts: Text.by_weight()])
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
end
