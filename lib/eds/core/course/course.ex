defmodule Eds.Core.Course do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eds.Core.{Course, Chapter, CourseCategory}
  alias Eds.Content.{Node, Text}
  alias Eds.Accounts.{UserCourse}
  alias Eds.{Repo}

  schema "courses" do
    field(:description, :string)
    field(:subtitle, :string)
    field(:title, :string)
    field :published, :boolean, default: false
    field :published_at, :utc_datetime

    has_many(:chapters, Chapter, on_delete: :delete_all)
    has_many(:nodes, Node, on_delete: :delete_all)
    has_many(:user_courses, UserCourse, on_delete: :delete_all)
    has_many(:users, through: [:user_courses, :user])
    has_many(:course_categories, CourseCategory)
    has_many(:categories, through: [:course_categories, :category])

    timestamps()
  end

  def preload_categories(course) do
    course
    |> Repo.preload(:course_categories)
    |> Repo.preload(:categories)
  end

  def preload_chapters(courses) do
    courses |> Repo.preload(:chapters)
  end

  def preload_nodes(course) do
    course
    |> Repo.preload(nodes: {Node.only_course, [texts: Text.by_weight]})
  end

  def preload_chapters_sections(courses) do
    courses |> Repo.preload(chapters: :sections)
  end

  @doc false
  def changeset(%Course{} = course, attrs) do
    course
    |> cast(attrs, [:title, :subtitle, :description, :published, :published_at])
    |> validate_required([:title, :subtitle])
    |> cast_assoc(:user_courses)
  end
end
