defmodule Project01Web.WorkingtimeController do
  use Project01Web, :controller

  alias Project01.Workingtimes
  alias Project01.Workingtimes.Workingtime
  # alias Project01.Users.User
  alias Project01.Users

  action_fallback Project01Web.FallbackController

  def index(conn, _params) do
    workingtimes = Workingtimes.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  # def create(conn, %{"workingtime" => workingtime_params}) do
  def create(conn, %{"userID" => user_id, "workingtime" => workingtime_params}) do
    
    user = Users.get_user!(user_id)
    IO.inspect(user)
    with {:ok, %Workingtime{} = workingtime} <- Workingtimes.create_workingtime(user ,workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def createClockIn(conn, %{"userID" => user_id}) do
    
    dt = NaiveDateTime.add(NaiveDateTime.utc_now(), 7200, :second)
    user = Users.get_user!(user_id)

    check_workingtime = Workingtimes.get_workingtimes_by_same_date!(user_id, dt)

    if check_workingtime == nil do
      my_workingtime = %{"start" => dt, "end" => dt, "user_id" => user_id}
      with {:ok, %Workingtime{} = workingtime} <- Workingtimes.create_workingtime(user, my_workingtime) do
        conn
        |> put_status(:created)
        |> render("show.json", workingtime: workingtime)
      end

    else
      conn
      |> json("Ce user a déjà clockIn!")
    end
  end

  def updateClockOut(conn, %{"userID" => user_id}) do
    
    dt = NaiveDateTime.add(NaiveDateTime.utc_now(), 7200, :second)
    user = Users.get_user!(user_id)

    my_workingtime = Workingtimes.get_workingtimes_by_same_date!(user_id, dt)

    if my_workingtime != nil do
      new_workingtime = %{"end" => dt}

      with {:ok, %Workingtime{} = workingtime} <- Workingtimes.update_workingtime(my_workingtime, new_workingtime) do
        render(conn, "show.json", workingtime: workingtime)
      end

    else
      conn
      |> json("Ce user n'a pas clockIn. ClockOut impossible")
    end
  end

  # def show(conn, %{"userID" => user_id}) do
  #   workingtime = Workingtimes.get_workingtime!(user_id)
  #   IO.inspect(workingtime)
  #   render(conn, "show.json", workingtime: workingtime)
  # end

  def show(conn, %{"userID" => user_id, "workingtimeID" => workingtime_id}) do
    workingtime = Workingtimes.get_workingtime_by_user_id!(user_id, workingtime_id)
    IO.inspect(user_id)
    render(conn, "show.json", workingtime: workingtime)
  end

  def show(conn, %{"userID" => user_id}) do
    workingtimes = Workingtimes.get_workingtimes_by_user_id!(user_id)
    IO.inspect(workingtimes)
    render(conn, "index.json", workingtimes: workingtimes)
  end


  def showAll(conn, _params) do
    workingtimes = Users.get!()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def showByUserId(conn, %{"userID" => user_id}) do
    workingtimes = Workingtimes.get_workingtimes_by_user_id!(user_id)
    IO.inspect(workingtimes)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Workingtimes.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Workingtimes.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    IO.inspect(id)
    workingtime = Workingtimes.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Workingtimes.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
