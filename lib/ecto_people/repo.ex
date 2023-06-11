defmodule EctoPeople.Repo do
  use Ecto.Repo,
    otp_app: :ecto_people,
    adapter: Ecto.Adapters.Postgres
end
