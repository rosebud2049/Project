defmodule Project01.Repo.Migrations.AddPasswordField do
  use Ecto.Migration

  def change do
    alter table("users") do 
    add :password,  :string, size: 100
    end
  end
end
