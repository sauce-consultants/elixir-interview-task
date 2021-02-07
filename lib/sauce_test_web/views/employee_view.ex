defmodule SauceTestWeb.EmployeeView do
  use SauceTestWeb, :view
  # Or use in web/web.ex
  use JaSerializer.PhoenixView

  has_one :company,
    serializer: SauceTestWeb.CompanyView,
    include: false,
    identifiers: :when_included

  attributes([:email, :first_name, :last_name, :started_at])
end
