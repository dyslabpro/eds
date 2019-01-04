defmodule Eds.Repo.Migrations.CreateChapters do
  use Ecto.Migration

  def change do
    create table(:chapters) do
      add :title, :string
      add :course_id, references(:courses)

      add :published, :boolean, default: false
      add :published_at, :naive_datetime
      timestamps()
    end

  end
end
