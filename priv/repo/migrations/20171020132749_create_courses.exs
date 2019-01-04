defmodule Eds.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :title, :string
      add :subtitle, :string
      add :description, :string

      add :published, :boolean, default: false
      add :published_at, :naive_datetime
      timestamps()
    end

  end
end
