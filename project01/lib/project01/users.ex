defmodule Project01.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Project01.Repo

  alias Project01.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by_id!(id_params) do
    query = (from u in User, 
      where: u.id == ^(id_params), 
      select: %User{id: u.id, username: u.username, email: u.email})
    Repo.one(query)
  end

  def get_myUsers!(attrs \\ %{}) do
    IO.inspect(attrs)
  end
  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

 def get_user_by_name!(username_param, email_param) do
  query = (from u in User, 
    where: u.username == ^(username_param), 
    select: %User{id: u.id, username: u.username, email: u.email})
  Repo.all(query)
 end
  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def list_users_by_username_and_by_email(username, email) do
    User
    |> where(username: ^username, email: ^email)
    |> Repo.all()
  end

  def list_users_by_username(username) do
    User
    |> where(username: ^username)
    |> Repo.all()
  end

  def list_users_by_email(email) do
    User
    |> where(email: ^email)
    |> Repo.all()
  end
end
