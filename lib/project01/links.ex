defmodule Project01.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias Project01.Repo

  alias Project01.Links.Link
  alias Project01.Users
  alias Project01.Users.User
  alias Project01.Teams
  alias Project01.Teams.Team
  @doc """
  Returns the list of link.

  ## Examples

      iex> list_link()
      [%Link{}, ...]

  """
  def list_link do
    Repo.all(Link)
  end

  @doc """
  Gets a single link.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link!(123)
      %Link{}

      iex> get_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link!(id), do: Repo.get!(Link, id)

  @doc """
  Creates a link.

  ## Examples

      iex> create_link(%{field: value})
      {:ok, %Link{}}

      iex> create_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link(attrs \\ %{}) do
    %Link{}
    |> Link.changeset(attrs)
    |> Repo.insert()
  end

  def create_link_by_id(%User{} = users, %Team{} = teams, attrs \\ %{}) do
    IO.inspect(users)
    %Link{}
    |> Link.changeset(attrs)
    |> Ecto.Changeset.put_change(:user_id, users.id)
    |> Ecto.Changeset.put_change(:team_id, teams.id)
    |> Repo.insert()
  end

  def get_link_by_same_ids!(userID, teamID) do
    query = (from u in Link,
                where: u.user_id == ^(userID) and u.team_id == ^(teamID),
                select: %Link{id: u.id, user_id: u.user_id, team_id: u.team_id})
    Repo.one(query)
  end

  def get_users_by_teamID!(teamID) do
    query = (from u in Link,
                where: u.team_id == ^(teamID),
                select: u.user_id)
    
    var = Repo.all(query)

    my_users = (from u in User,
                  where: u.id in ^(var),
                  select: %User{id: u.id, username: u.username, email: u.email})

    Repo.all(my_users)
  end

  def get_teams_by_userID!(userID) do
    query = (from u in Link,
                where: u.user_id == ^(userID),
                select: u.team_id)

    var = Repo.all(query)

    my_teams = (from u in Team,
                    where: u.id in ^(var),
                    select: %Team{id: u.id, name: u.name})

    Repo.all(my_teams)    
  end

  @doc """
  Updates a link.

  ## Examples

      iex> update_link(link, %{field: new_value})
      {:ok, %Link{}}

      iex> update_link(link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Link.

  ## Examples

      iex> delete_link(link)
      {:ok, %Link{}}

      iex> delete_link(link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.

  ## Examples

      iex> change_link(link)
      %Ecto.Changeset{source: %Link{}}

  """
  def change_link(%Link{} = link) do
    Link.changeset(link, %{})
  end
end
