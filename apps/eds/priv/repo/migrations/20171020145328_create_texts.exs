defmodule Eds.Repo.Migrations.CreateTexts do
  use Ecto.Migration

  def change do
    create table(:texts) do
      add :title, :string
      add :text, :text
      add :position, :integer, null: false, default: 0
      add :weight, :integer
      add :node_id, references(:nodes)

      timestamps()
    end

  end
end
