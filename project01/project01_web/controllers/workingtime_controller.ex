defmodule Project01Web.WorkingtimeController do
  use Project01Web, :controller
  use PhoenixSwagger

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

    ## On vérifie qu'il n'y a pas déjà de clockIn pour ce user
    check_workingtime = Workingtimes.get_workingtimes_by_same_date!(user_id, dt)
    IO.inspect(check_workingtime)

    if check_workingtime == nil do
      my_workingtime = %{"start" => dt, "end" => dt, "user_id" => user_id}
      IO.inspect(my_workingtime)
      with {:ok, %Workingtime{} = workingtime} <- Workingtimes.create_workingtime(user ,my_workingtime) do
        conn
        |> put_status(:created)
        |> render("show.json", workingtime: workingtime)
      end

      else
        IO.inspect(check_workingtime)
        conn
        |> json("Ce user a deja clockIn!")
    end
  end

  def updateClockOut(conn, %{"userID" => user_id}) do

    # On récupère la date et l'heure actuelle
    dt = NaiveDateTime.add(NaiveDateTime.utc_now(), 7200, :second)
    user = Users.get_user!(user_id)

    IO.inspect(user)
    ## On recupere le workingTime (clockIn)
    my_workingtime = Workingtimes.get_workingtimes_by_same_date!(user_id, dt)
    IO.inspect(my_workingtime)

    if my_workingtime != nil do
      ## On créé un nouveau workingTime (clockOut)
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

  def showForPeriod(conn, %{"userID" => userID, "start" => p_start, "end" => p_end}) do
    IO.inspect(userID)
    workingtimes = Workingtimes.get_workingtimes_by_period_and_userID!(userID, p_start, p_end)
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

  swagger_path :show do
    get "/api/workingtimes/{user_id}/{workingtime_id}"
    summary "Query for working times"
    description "Query for working times. This operation display the working times for the corresponding user id and working time id"
    parameters do
      user_id :path, :integer, "User ID", required: true, example: 2
      workingtime_id :path, :integer, "WorkingTimes ID", required: true, example: 2
    end
    response 200, "OK"
  end

  swagger_path :showForPeriod do
    get "/api/workingtimes?userID={user_id}&start={start_date}&end={end_date}"
    summary "Get period of a user"
    description "Get working time of a user with corresponding id and working period"
    parameters do
      user_id :path, :integer, "User ID", required: true, example: 2
      start_date :path, :datetime, "Start Date", required: true, example: "2019-09-11 14:50:12"
      end_date :path, :datetime, "End Date", required: true, example: "2019-09-11 14:50:12"
    end
    response 200, "OK"
  end

  swagger_path :create do
    post "/api/workingtimes"
    summary "Create working time"
    description "Create a working time for a user give in parameters"
    parameters do
      start :query, :datetime, "Start Date", required: true, example: "2019-09-11 14:50:12"
      end_date :query, :datetime, "End Date", required: true, example: "2019-09-11 14:50:12"
      user_id :query, :integer, "User ID", required: true, example: 2
    end
    response 200, "OK"
  end

  swagger_path :createClockIn do
    post "/api/workingtimes/clock_in/{user_id}"
    summary "Create a clock in"
    description "Create a working time when a user make a clock in"
    parameter :user_id, :path, :integer, "User ID", required: true, example: 2
    response 201, "OK"
    response 200, "User already clock in "
    response 404, "Not Found"
  end

  swagger_path :updateClockOut do
    put "/api/workingtimes/clock_out/{user_id}"
    summary "Create a clock out"
    description "Create a clock out and update an existing working time"
    parameter :user_id, :path, :integer, "User ID", required: true, example: 2
    response 200, "OK"
    response 200, "User already clock out "
    response 404, "Not Found"
  end

  swagger_path :update do
    put "/api/workingtimes/{workingtime_id}"
    summary "Update working time"
    description "Update a working time for a working time with the corresponding id"
    parameter :workingtime_id, :path, :integer, "WorkingTime ID", required: true, example: 2
    response 200, "OK"
    response 404, "Not Found"
  end

  swagger_path :delete do
    PhoenixSwagger.Path.delete "/api/workingtimes/{workingtime_id}"
    summary "Delete a working time"
    description "Delete a working time with the corresponding id"
    parameter :workingtime_id, :path, :integer, "WorkingTime ID", required: true, example: 2
    response 204, "No Content - Deleted Successfully"
    response 500, "User not found"
  end

  
end
