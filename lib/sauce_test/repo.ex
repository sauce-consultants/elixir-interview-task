defmodule SauceTest.Repo do
  use Ecto.Repo,
    otp_app: :sauce_test,
    adapter: Ecto.Adapters.Postgres
end
