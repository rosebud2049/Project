defmodule Project01Web.ClockController do
  use Project01Web, :controller

  alias Project01.Clocks
  alias Project01.Clocks.Clock
  alias Project01.Users

  action_fallback Project01Web.FallbackController

  def index(conn, _params) do
    clocks = Clocks.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"userID" => user_id, "clock" => clock_params}) do

    user = Users.get_user!(user_id)
    IO.inspect(user)
    with {:ok, %Clock{} = clock} <- Clocks.create_clock(user, clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  # def show(conn, %{"userID" => user_id}) do
  #   clock = Clocks.get_clock!(user_id)
  #   IO.inspect(clock)
  #   render(conn, "show.json", clock: clock)
  # end

  def show(conn, %{"userID" => user_id}) do
    clocks = Clocks.get_clocks_by_user_id!(user_id)
    IO.inspect(clocks)
    render(conn, "index.json", clocks: clocks)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Clocks.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Clocks.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Clocks.get_clock!(id)

    with {:ok, %Clock{}} <- Clocks.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
