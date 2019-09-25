defmodule Project01.Repo.Migrations.CreateLink do
  use Ecto.Migration

  def change do
    create table(:link) do
      add :user_id, references(:users, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end

    create index(:link, [:user_id])
    create index(:link, [:team_id])
  end
end
