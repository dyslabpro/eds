defmodule Eds.Repo.Migrations.CreateNodes do
  use Ecto.Migration

  def change do
    create table(:nodes) do
      add :title, :string
      add :text, :text
      add :course_id, references(:courses)
      add :chapter_id, references(:chapters)
      add :section_id, references(:sections)

      add :published, :boolean, default: false
      add :published_at, :naive_datetime
      timestamps()
    end

  end
end
