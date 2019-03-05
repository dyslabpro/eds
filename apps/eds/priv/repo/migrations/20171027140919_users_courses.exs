defmodule Eds.Repo.Migrations.UserCourses do
  use Ecto.Migration

  def change do
     create table(:user_courses) do
       add :role, :integer
       add :user_id, references(:users)
       add :course_id, references(:courses)
       add :chapter_id, references(:chapters)
       add :section_id, references(:sections)

       timestamps()
     end
  end
end
