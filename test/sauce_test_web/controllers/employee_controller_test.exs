defmodule SauceTestWeb.EmployeeControllerTest do
  use SauceTestWeb.ConnCase

  alias SauceTest.Companies
  alias SauceTest.Companies.Company
  alias SauceTest.Companies.Employee

  @company_attrs %{
    "address_line_1" => "some address_line_1",
    "name" => "some name",
    "postcode" => "some postcode"
  }

  @create_attrs %{
    "email" => "some email",
    "first_name" => "some first_name",
    "last_name" => "some last_name",
    "started_at" => ~D[2010-04-17]
  }
  @update_attrs %{
    "email" => "some updated email",
    "first_name" => "some updated first_name",
    "last_name" => "some updated last_name",
    "started_at" => ~D[2011-05-18]
  }
  @invalid_attrs %{email: nil, first_name: nil, last_name: nil, started_at: nil}

  def fixture(:employee) do
    {:ok, company} = Companies.create_company(@company_attrs)
    {:ok, employee} = Companies.create_employee(@create_attrs, company)
    employee
  end

  def fixture(:company) do
    {:ok, company} = Companies.create_company(@company_attrs)
    company
  end

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all employees", %{conn: conn} do
      conn = get(conn, Routes.employee_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "show" do
    setup [:create_employee]

    test "show an employee", %{conn: conn, employee: %Employee{id: id} = employee} do
      conn = get(conn, Routes.employee_path(conn, :show, id))

      assert %{
               "id" => id,
               "attributes" => %{
                 "email" => "some email",
                 "first-name" => "some first_name",
                 "last-name" => "some last_name",
                 "started-at" => "2010-04-17"
               },
               "type" => "employee"
             } = json_response(conn, 200)["data"]
    end
  end

  describe "create employee" do
    setup [:create_company]

    test "renders employee when data is valid", %{
      conn: conn,
      company: %Company{id: company_id} = company
    } do
      params =
        Jason.encode!(%{
          data: %{
            attributes: @create_attrs,
            relationships: %{company: %{data: %{id: company_id, type: "company"}}}
          }
        })

      conn = post(conn, Routes.employee_path(conn, :create), params)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.employee_path(conn, :show, id))

      assert %{
               "id" => id,
               "attributes" => %{
                 "email" => "some email",
                 "first-name" => "some first_name",
                 "last-name" => "some last_name",
                 "started-at" => "2010-04-17"
               },
               "type" => "employee"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      company: %Company{id: company_id} = company
    } do
      params =
        Jason.encode!(%{
          data: %{
            attributes: @invalid_attrs,
            relationships: %{company: %{data: %{id: company_id, type: "company"}}}
          }
        })

      conn = post(conn, Routes.employee_path(conn, :create), params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update employee" do
    setup [:create_employee]

    test "renders employee when data is valid", %{
      conn: conn,
      employee: %Employee{id: id} = employee
    } do
      params = Jason.encode!(%{data: %{attributes: @update_attrs}})
      conn = put(conn, Routes.employee_path(conn, :update, employee), params)
      assert %{"id" => id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.employee_path(conn, :show, id))

      assert %{
               "id" => id,
               "attributes" => %{
                 "email" => "some updated email",
                 "first-name" => "some updated first_name",
                 "last-name" => "some updated last_name",
                 "started-at" => "2011-05-18"
               },
               "type" => "employee"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, employee: employee} do
      params = Jason.encode!(%{data: %{attributes: @invalid_attrs}})
      conn = put(conn, Routes.employee_path(conn, :update, employee), params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete employee" do
    setup [:create_employee]

    test "deletes chosen employee", %{conn: conn, employee: employee} do
      conn = delete(conn, Routes.employee_path(conn, :delete, employee))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.employee_path(conn, :show, employee))
      end
    end
  end

  defp create_employee(_) do
    employee = fixture(:employee)
    %{employee: employee}
  end

  defp create_company(_) do
    company = fixture(:company)
    %{company: company}
  end
end
