defmodule Project01Web.UserController do
  use Project01Web, :controller
  use PhoenixSwagger

  alias Project01.Users
  alias Project01.Users.User

  action_fallback Project01Web.FallbackController
  
  def index(conn, %{"username" => username, "email" => email}) do
    users = Users.list_users_by_username_and_by_email(username, email)
    render(conn, "index.json", users: users)
  end

  def index(conn, %{"username" => username}) do
    users = Users.list_users_by_username(username)
    render(conn, "index.json", users: users)
  end

  def index(conn, %{"email" => email}) do
    users = Users.list_users_by_email(email)
    render(conn, "index.json", users: users)
  end

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end


  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def promote(conn, %{"userID" => user_id, "user" => user_params}) do
    user = Users.get_user!(user_id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  swagger_path :index do
    get "/api/users?email={email}&username={username}"
    summary "Get a user"
    description "Query for users. This operation display the user with the corresponding email and/or username"
    parameters do
      username :query, :string, "Username", example: "eric Marc"
      email :query, :string, "Email", example: "eric.martin@mail.com"
      role :query, :string, "Role", example: "manager"
    end
    response 200, "OK"
    response 400, "Error"
  end

  swagger_path :show do
    get "/api/users/{user_id}"
    summary "Query for users"
    description "Query for users. This operation display the user with the corresponding id"
    parameter :user_id, :path, :integer, "User ID", required: true, example: 2
    response 200, "OK"
    response 400, "Error"
  end

  swagger_path :create do
    post "/api/users"
    summary "Create a user"
    description "Creation of a user with parameters"
    parameters do
      username :query, :string, "Username", example: "eric Marc"
      email :query, :string, "Email", example: "eric.martin@mail.com"
      role :query, :string, "Role", example: "manager"
    end
    response 201, "OK"
    response 422, "Parameter missing"
  end

  swagger_path :update do
    put "/api/users/{user_id}"
    summary "Update a user"
    description "Update of a user with correspond id"
    parameters do
      user_id :path, :integer, "User ID", required: true, example: 2
      username :query, :string, "Username", example: "eric Marc"
      email :query, :string, "Email", example: "eric.martin@mail.com"
    end
    response 200, "OK"
    response 404, "User not foud"
  end

  swagger_path :delete do
    PhoenixSwagger.Path.delete "/api/users/{user_id}"
    summary "Delete a user"
    description "Delete of a user with corresponding id"
    parameter :user_id, :path, :integer, "User ID", required: true, example: 2
    response 204, "No Content - Deleted Successfully"
    response 500, "User not found"
  end
end
