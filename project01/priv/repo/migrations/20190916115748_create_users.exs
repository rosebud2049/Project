defmodule Project01.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password_hash, :string, size: 100
      add :role, :string

      timestamps()
    end
    create unique_index(:users, [:email])
  end
end
