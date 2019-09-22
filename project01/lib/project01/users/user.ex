defmodule Project01.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    field :password_hash, :string, size: 100
    field :role, :string
    field :password, :string, virtual: true
    #field :password_confirmation, :string, virtual: true
    has_many :workingtimes, Project01.Workingtimes.Workingtime
    has_many :clocks, Project01.Clocks.Clock
    
    timestamps()
  end

  @doc false
  user
  def changeset(user, attrs) do
    |> cast(attrs, [:username, :email, :password_hash, :role])
    |> validate_required([:username, :email, :password_hash])
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
     %Ecto.Changeset{valid?: true, changes: %{password_hash: pwd}} -> 
     put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pwd))
   _ ->
     changeset
    end
  end
end
