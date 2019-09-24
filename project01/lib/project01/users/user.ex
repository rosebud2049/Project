defmodule Project01.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    field :password_hash, :string, size: 100
    field :role, :string
    field :password, :string, virtual: true
    has_many :workingtimes, Project01.Workingtimes.Workingtime
    has_many :clocks, Project01.Clocks.Clock
    
    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:username, :email, :password, :role])
    |> validate_required([:email, :password])
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
     %Ecto.Changeset{valid?: true, changes: %{password: pwd}} -> 
     put_change(changeset, :password_hash, Base.encode16(:crypto.hash(:sha256, pwd)))
   _ ->
     changeset
    end
  end
end
