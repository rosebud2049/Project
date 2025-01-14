defmodule Project01Web.Router do
  use Project01Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Project01Web do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Project01Web do
    pipe_through :api

    post "/users", UserController, :create
    get "/users/:id", UserController, :show
    put "/users/:id", UserController, :update
    # delete "/users/:id", UserController, :delete

    post "/workingtimes/:userID", WorkingtimeController, :create
    get "/workingtimes/:userID", WorkingtimeController, :show
    # get "/workingtimes/:userID", WorkingtimeController, :showByUserId
    delete "/workingtimes/:userID", WorkingtimeController, :delete

  end
end
