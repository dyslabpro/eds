defmodule Eds.Accounts.UserCourse do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Eds.Accounts.{User}
  alias Eds.Core.{Course, Chapter, Section}

  schema "user_courses" do
    field(:role, :integer)
    belongs_to(:user, User)
    belongs_to(:course, Course)
    belongs_to(:chapter, Chapter)
    belongs_to(:section, Section)

    timestamps()
  end

  def by_role(query \\ __MODULE__, role \\ 1) do
    from(u in query, where: u.role == ^role)
  end

  @doc false
  def changeset(struct, attrs) do
    struct
    |> cast(attrs, [:role, :user_id, :course_id, :chapter_id, :section_id])
    |> validate_required([:role])
  end
end
