defmodule Eds.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :handle, :string
      add :facebook_handle, :string
      add :google_handle, :string
      add :twitter_handle, :string
      add :website, :string
      add :auth_token, :string
      add :auth_token_expires_at, :naive_datetime
      add :joined_at, :naive_datetime
      add :signed_in_at, :naive_datetime
      add :admin, :boolean, default: false, null: false
      add :teacher, :boolean, default: false, null: false
      add :student, :boolean, default: false, null: false
      add :avatar, :string

      timestamps()
    end

  end
end
