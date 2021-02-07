defmodule SauceTestWeb.CompanyControllerTest do
  use SauceTestWeb.ConnCase

  alias SauceTest.Companies
  alias SauceTest.Companies.Company

  @create_attrs %{
    address_line_1: "some address_line_1",
    name: "some name",
    postcode: "some postcode"
  }
  @update_attrs %{
    address_line_1: "some updated address_line_1",
    name: "some updated name",
    postcode: "some updated postcode"
  }
  @invalid_attrs %{address_line_1: nil, name: nil, postcode: nil}

  def fixture(:company) do
    {:ok, company} = Companies.create_company(@create_attrs)
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
    test "lists all companies", %{conn: conn} do
      conn = get(conn, Routes.company_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create company" do
    test "renders company when data is valid", %{conn: conn} do
      params = Jason.encode!(%{data: %{attributes: @create_attrs}})

      conn = post(conn, Routes.company_path(conn, :create), params)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.company_path(conn, :show, id))

      assert %{
               "id" => id,
               "attributes" => %{
                 "address-line-1" => "some address_line_1",
                 "name" => "some name",
                 "postcode" => "some postcode"
               },
               "type" => "company"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      params = Jason.encode!(%{data: %{attributes: @invalid_attrs}})
      conn = post(conn, Routes.company_path(conn, :create), params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update company" do
    setup [:create_company]

    test "renders company when data is valid", %{conn: conn, company: %Company{id: id} = company} do
      params = Jason.encode!(%{data: %{attributes: @update_attrs}})

      conn = put(conn, Routes.company_path(conn, :update, company), params)

      assert %{
               "id" => id,
               "attributes" => %{
                 "address-line-1" => "some updated address_line_1",
                 "name" => "some updated name",
                 "postcode" => "some updated postcode"
               },
               "type" => "company"
             } = json_response(conn, 200)["data"]

      conn = get(conn, Routes.company_path(conn, :show, id))

      assert %{
               "id" => id,
               "attributes" => %{
                 "address-line-1" => "some updated address_line_1",
                 "name" => "some updated name",
                 "postcode" => "some updated postcode"
               },
               "type" => "company"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, company: company} do
      params = Jason.encode!(%{data: %{attributes: @invalid_attrs}})
      conn = put(conn, Routes.company_path(conn, :update, company), params)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete company" do
    setup [:create_company]

    test "deletes chosen company", %{conn: conn, company: company} do
      conn = delete(conn, Routes.company_path(conn, :delete, company))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.company_path(conn, :show, company))
      end
    end
  end

  defp create_company(_) do
    company = fixture(:company)
    %{company: company}
  end
end
