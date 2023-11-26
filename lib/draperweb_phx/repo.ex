defmodule DraperWebPhx.Repo do
  use Ecto.Repo,
    otp_app: :draperweb_phx,
    adapter: Ecto.Adapters.Postgres
end
