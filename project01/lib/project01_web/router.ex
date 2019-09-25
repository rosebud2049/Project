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
    resources "/users", UserController, except: [:new, :edit]
    options   "/users", UserController, :options

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

    #### ----- Gestion des Teams ----- ####
    post "/teams", TeamController, :create
    get "/teams/:id", TeamController, :show

    # Ajouter un user dans une team
    post "/manager/add/:userID/:teamID", LinkController, :addIntoTeam
    #  Voir tous les users d'une Team via teamID
    get "/manager/viewUsers/:teamID", LinkController, :viewAllUsersByTeam
    # Voir les teams d'un user via userID
    get "/manager/viewTeams/:userID", LinkController, :viewAllTeamsByUser
    # Promouvoir un user "employee" -> "manager"
    put "/manager/promote/:userID", UserController, :promote
  end
end
