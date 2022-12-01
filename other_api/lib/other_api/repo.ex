defmodule OtherApi.Repo do
  use Ecto.Repo,
    otp_app: :other_api,
    adapter: Ecto.Adapters.Postgres
end
