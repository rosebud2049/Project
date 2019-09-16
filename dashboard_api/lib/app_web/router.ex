defmodule DashboardWeb.Router do
  use DashboardWeb, :router

  pipeline :api do
  
    plug :accepts, ["json"]
  end

  scope "/api", DashboardWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    options   "/users", UserController, :options
  end
end
