defmodule Eds.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :title, :string
      add :image, :string
      add :position, :integer, null: false, default: 0
      add :weight, :integer
      add :node_id, references(:nodes)

      timestamps()
    end

  end
end
