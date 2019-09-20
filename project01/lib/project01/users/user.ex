defmodule Project01.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string
    field :role, :string
    has_many :workingtimes, Project01.Workingtimes.Workingtime
    has_many :clocks, Project01.Clocks.Clock
    
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :role])
    |> validate_required([:username, :email, :password, :role])
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    case changeset do
     %Ecto.Changeset{valid?: true, changes: %{password: pwd}} -> 
     put_change(changeset, :password, Bcrypt.hash_pwd_salt(pwd))
   _ ->
     changeset
    end
  end
end
