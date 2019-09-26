defmodule Project01Web.Router do
  use Project01Web, :router

  alias Project01.Guardian

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

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/", Project01Web do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Project01Web do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    options   "/users", UserController, :options
    post "/users/sign_up", UserController, :create
    post "/users/sign_in", UserController, :sign_in

    post "/workingtimes/:userID", WorkingtimeController, :create
    post "/workingtimes/clock_in/:userID", WorkingtimeController, :createClockIn
    put "/workingtimes/clock_out/:userID", WorkingtimeController, :updateClockOut
    
    get "/workingtimes/:userID/:workingtimeID", WorkingtimeController, :show
    get "/workingtimes", WorkingtimeController, :index
    get "/workingtimes/:userID", WorkingtimeController, :show
    delete "/workingtimes/:id", WorkingtimeController, :delete
    put "/workingtimes/:id", WorkingtimeController, :update

    post "/clocks/:userID", ClockController, :create
    get "/clocks/:userID", ClockController, :show
  end

  scope "/api", Project01Web do
    pipe_through [:api, :jwt_authenticated]

    get "/my_user", UserController, :show
  end
end
