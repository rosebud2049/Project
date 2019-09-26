defmodule Project01.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "link" do
    # field :user_id, :id
    # field :team_id, :id
    belongs_to(:user, Project01.Users.User)
    belongs_to(:team, Project01.Teams.Team)

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [])
    |> validate_required([])
  end
end
