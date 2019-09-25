defmodule Project01Web.WorkingtimeView do
  use Project01Web, :view
  alias Project01Web.WorkingtimeView

  def render("index.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingtimeView, "workingtime.json")}
  end

  def render("show.json", %{workingtime: workingtime}) do
    %{data: render_one(workingtime, WorkingtimeView, "workingtime.json")}
  end

  def render("workingtime.json", %{workingtime: workingtime}) do
    %{id: workingtime.id,
      start: workingtime.start,
      end: workingtime.end}
  end

  # def render("param", %{workingtime: workingtime}) do
  #   conn
  #   |> json ("error !!")
  # end
end
