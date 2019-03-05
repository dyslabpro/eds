defmodule Eds.Core.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eds.Core.{CourseCategory, Category}
  alias Eds.{Repo}

  schema "categories" do
    field(:title, :string)

    has_many(:course_categories, CourseCategory)
    has_many(:courses, through: [:course_categories, :course])

    timestamps()
  end
  def get_category_with_courses(id) do
    Repo.get!(Category, id) |> Category.preload_courses()
  end

  def preload_courses(category) do
    category
    |> Repo.preload(:course_categories)
    |> Repo.preload(:courses)
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
