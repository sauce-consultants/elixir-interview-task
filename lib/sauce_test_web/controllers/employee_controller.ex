defmodule SauceTestWeb.EmployeeController do
  use SauceTestWeb, :controller

  alias SauceTest.Companies
  alias SauceTest.Companies.Employee

  action_fallback SauceTestWeb.FallbackController

  def index(conn, params) do
    employees = Companies.list_employees()
    render(conn, "index.json-api", data: employees, opts: [include: params["include"]])
  end

  def create(conn, %{"data" => data}) do
    attrs = JaSerializer.Params.to_attributes(data)
    company = Companies.get_company!(attrs["company_id"])

    with {:ok, %Employee{} = employee} <- Companies.create_employee(attrs, company) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.employee_path(conn, :show, employee))
      |> render("show.json-api", data: employee)
    end
  end

  def show(conn, %{"id" => id} = params) do
    employee = Companies.get_employee!(id)

    render(conn, "show.json-api", data: employee, opts: [include: params["include"]])
  end

  def update(conn, %{"id" => id, "data" => data}) do
    attrs = JaSerializer.Params.to_attributes(data)

    employee = Companies.get_employee!(id)

    with {:ok, %Employee{} = employee} <- Companies.update_employee(employee, attrs) do
      render(conn, "show.json-api", data: employee)
    end
  end

  def delete(conn, %{"id" => id}) do
    employee = Companies.get_employee!(id)

    with {:ok, %Employee{}} <- Companies.delete_employee(employee) do
      send_resp(conn, :no_content, "")
    end
  end
end
