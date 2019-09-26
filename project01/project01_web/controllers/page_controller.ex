defmodule Project01Web.PageController do
  use Project01Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
