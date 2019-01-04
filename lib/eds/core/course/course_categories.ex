defmodule Eds.Core.CourseCategory do
  use Ecto.Schema
  import Ecto.Changeset

  alias Eds.Core.{Course, Category}

  schema "course_categories" do
    belongs_to(:course, Course)
    belongs_to(:category, Category)

    timestamps()
  end

  @doc false
  def changeset(struct, attrs) do
    struct
    |> cast(attrs, [:course_id, :category_id])
    |> validate_required([:course_id, :category_id])
  end
end
