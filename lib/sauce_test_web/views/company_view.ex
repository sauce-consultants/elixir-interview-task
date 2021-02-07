defmodule SauceTestWeb.CompanyView do
  use SauceTestWeb, :view
  # Or use in web/web.ex
  use JaSerializer.PhoenixView

  attributes([:name, :address_line_1, :postcode])
end
