defmodule Hosp.Repo do
  use Ecto.Repo,
    otp_app: :hosp,
    adapter: Ecto.Adapters.Postgres
end
