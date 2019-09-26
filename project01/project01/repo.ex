defmodule Project01.Repo do
  use Ecto.Repo,
    otp_app: :project01,
    adapter: Ecto.Adapters.Postgres
end
