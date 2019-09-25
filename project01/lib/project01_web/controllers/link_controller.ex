defmodule Project01Web.LinkController do
  use Project01Web, :controller

  alias Project01.Links
  alias Project01.Links.Link
  alias Project01.Users
  alias Project01.Users.User
  alias Project01.Teams
  alias Project01.Teams.Team

  action_fallback Project01Web.FallbackController

  def index(conn, _params) do
    link = Links.list_link()
    render(conn, "index.json", link: link)
  end

  def create(conn, %{"link" => link_params}) do
    with {:ok, %Link{} = link} <- Links.create_link(link_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.link_path(conn, :show, link))
      |> render("show.json", link: link)
    end
  end

  def addIntoTeam(conn, %{"userID" => user_id, "teamID" => team_id}) do
    user = Users.get_user_by_id!(user_id)
    team = Teams.get_team_by_id!(team_id)

    check_link = Links.get_link_by_same_ids!(user_id, team_id)
    IO.inspect(check_link)
    if check_link != nil do
      conn
      |> json("ce user a deja été assigné dans cette team !")
    else
      if user == nil or team == nil do
        IO.inspect(team)
        conn
        |> json("team ou user inexistant !")
      else
        with {:ok, %Link{} = link} <- Links.create_link_by_id(user, team) do
          conn
          |> put_status(:created)
          |> render("show.json", link: link)
        end
      end
    end
  end

  def viewAllUsersByTeam(conn, %{"teamID" => team_id}) do
    user_list = Links.get_users_by_teamID!(team_id)
    
    conn
    |> put_status(:created)
    |> render("show.json", user: user_list)
  end

  def viewAllTeamsByUser(conn, %{"userID" => user_id}) do
    team_list = Links.get_teams_by_userID!(user_id)

    conn
    |> put_status(:created)
    |> render("show.json", team: team_list)
  end

  def show(conn, %{"id" => id}) do
    link = Links.get_link!(id)
    render(conn, "show.json", link: link)
  end

  def update(conn, %{"id" => id, "link" => link_params}) do
    link = Links.get_link!(id)

    with {:ok, %Link{} = link} <- Links.update_link(link, link_params) do
      render(conn, "show.json", link: link)
    end
  end

  def delete(conn, %{"id" => id}) do
    link = Links.get_link!(id)

    with {:ok, %Link{}} <- Links.delete_link(link) do
      send_resp(conn, :no_content, "")
    end
  end
end
