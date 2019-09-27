defmodule Project01Web.TeamController do
  use Project01Web, :controller
  use PhoenixSwagger

  alias Project01.Teams
  alias Project01.Teams.Team

  action_fallback Project01Web.FallbackController

  def index(conn, _params) do
    teams = Teams.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    with {:ok, %Team{} = team} <- Teams.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :show, team))
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Teams.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Teams.get_team!(id)

    with {:ok, %Team{} = team} <- Teams.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Teams.get_team!(id)

    with {:ok, %Team{}} <- Teams.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end

  swagger_path :create do
    post "/api/teams"
    summary "Create a team"
    description "Creation of a team with a name"
    parameters do
      username :name, :string, "Name", example: "Marketing"
    end
    response 201, "OK"
    response 422, "Parameter missing"
  end

  swagger_path :show do
    get "/api/teams/{team_id}"
    summary "Get a team"
    description "Get the team with the corresponding id"
    parameter :team_id, :path, :integer, "Team ID", required: true, example: 2
    response 200, "OK"
    response 400, "Error"
  end
end
