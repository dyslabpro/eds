defmodule Eds.Repo.Migrations.CreateQuizQuestions do
  use Ecto.Migration

  def change do
    create table(:quiz_questions) do
      add :title, :string
      add :question, :text
      add :options, :text
      add :position, :integer, null: false, default: 0
      add :weight, :integer
      add :node_id, references(:nodes)

      timestamps()
    end

  end
end
