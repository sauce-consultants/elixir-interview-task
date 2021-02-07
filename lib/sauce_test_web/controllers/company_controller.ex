defmodule SauceTestWeb.CompanyController do
  use SauceTestWeb, :controller

  alias SauceTest.Companies
  alias SauceTest.Companies.Company

  action_fallback SauceTestWeb.FallbackController

  def index(conn, _params) do
    companies = Companies.list_companies()
    render(conn, "index.json-api", data: companies)
  end

  def show(conn, %{"id" => id}) do
    company = Companies.get_company!(id)
    render(conn, "show.json-api", data: company)
  end
end
