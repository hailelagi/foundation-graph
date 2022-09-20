defmodule Fnd.Repo do
  use Ecto.Repo,
    otp_app: :fnd,
    adapter: Ecto.Adapters.Postgres
end
