defmodule Eds.Core.Course do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eds.Core.{Course, Chapter, CourseCategory, Section}
  alias Eds.Content.{Node, Text, Image, QuizQuestion}
  alias Eds.Accounts.{UserCourse}
  alias Eds.{Repo}

  schema "courses" do
    field(:description, :string)
    field(:subtitle, :string)
    field(:title, :string)
    field(:published, :boolean, default: false)
    field(:published_at, :utc_datetime)

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
    |> Repo.preload(
      nodes:
        {Node.only_course(),
         [
           texts: Text.by_weight(),
           images: Image.by_weight(),
           quiz_questions: QuizQuestion.by_weight()
         ]}
    )
  end

  def preload_chapters_sections(courses) do
    courses
    |> Repo.preload(chapters: {Chapter.by_weight(), [sections: Section.by_weight()]})
  end

  def list_courses do
    Repo.all(Course)
  end

  def get_course!(id), do: Repo.get!(Course, id)

  def create_course(attrs \\ %{}) do
    %Course{}
    |> Course.changeset(attrs)
    |> Repo.insert()
  end

  def update_course(%Course{} = course, attrs) do
    course
    |> Course.changeset(attrs)
    |> Repo.update()
  end

  def delete_course(%Course{} = course) do
    Repo.delete(course)
  end

  def change_course(%Course{} = course) do
    Course.changeset(course, %{})
  end

  @doc false
  def changeset(%Course{} = course, attrs) do
    course
    |> cast(attrs, [:title, :subtitle, :description, :published, :published_at])
    |> validate_required([:title, :subtitle])
    |> cast_assoc(:user_courses)
  end
end
