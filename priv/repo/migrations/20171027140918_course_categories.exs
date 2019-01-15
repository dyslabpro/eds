defmodule Eds.Repo.Migrations.CourseCategories do
  use Ecto.Migration

  def change do
     create table(:course_categories) do
       add :course_id, references(:courses)
       add :category_id, references(:categories)

       timestamps()
     end
  end
end
