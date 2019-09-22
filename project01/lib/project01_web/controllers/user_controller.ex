defmodule Project01Web.UserController do
  use Project01Web, :controller

  alias Project01.Users
  alias Project01.Users.User
  alias Project01.Guardian

  action_fallback Project01Web.FallbackController

  
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn 
      |> render("jwt.json", jwt: token)
    end
  end
  
  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Users.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end
  
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
  
  #def create(conn, %{"user" => user_params}) do
  #  with {:ok, %User{} = user} <- Users.create_user(user_params) do
  #    conn
  #     |> put_status(:created)
  #    |> put_resp_header("location", Routes.user_path(conn, :show, user))
  #    |> render("show.json", user: user)
  #  end
  #end


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
end
