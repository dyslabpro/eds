defmodule Eds.Repo.Migrations.CreateSections do
  use Ecto.Migration

  def change do
    create table(:sections) do
      add :title, :string
      add :weight, :integer
      add :chapter_id, references(:chapters)

      add :published, :boolean, default: false
      add :published_at, :naive_datetime
      timestamps()
    end

  end
end
