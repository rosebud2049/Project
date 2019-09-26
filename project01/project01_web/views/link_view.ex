defmodule Project01Web.LinkView do
  use Project01Web, :view
  alias Project01Web.LinkView
  alias Project01Web.UserView
  alias Project01Web.TeamView

  def render("index.json", %{link: link}) do
    %{data: render_many(link, LinkView, "link.json")}
  end

  def render("show.json", %{link: link}) do
    %{data: render_one(link, LinkView, "link.json")}
  end

  def render("link.json", %{link: link}) do
    %{id: link.id}
  end

  def render("show.json", %{user: link}) do
    %{data: render_many(link, UserView, "user.json")}
  end

  def render("show.json", %{team: link}) do
    %{data: render_many(link, TeamView, "team.json")}
  end
end
