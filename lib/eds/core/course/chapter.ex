defmodule Eds.Core.Chapter do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eds.Core.{Chapter, Course, Section}
  alias Eds.{Repo}

  schema "chapters" do
    field(:title, :string)
    field :published, :boolean, default: false
    field :published_at, :utc_datetime

    belongs_to(:course, Course)
    has_many(:sections, Section, on_delete: :delete_all)

    timestamps()
  end

  def get_sections(chapter) do
    chapter
    |> Repo.preload(:sections)
  end

  @doc false
  def changeset(%Chapter{} = chapter, attrs) do
    chapter
    |> cast(attrs, [:title, :course_id, :published, :published_at])
    |> validate_required([:title])
  end
end
