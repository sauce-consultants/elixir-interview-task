defmodule SauceTest.CompaniesTest do
  use SauceTest.DataCase

  alias SauceTest.Companies

  describe "companies" do
    alias SauceTest.Companies.Company

    @valid_attrs %{
      "address_line_1" => "some address_line_1",
      "name" => "some name",
      "postcode" => "some postcode"
    }
    @update_attrs %{
      "address_line_1" => "some updated address_line_1",
      "name" => "some updated name",
      "postcode" => "some updated postcode"
    }
    @invalid_attrs %{address_line_1: nil, name: nil, postcode: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Companies.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Companies.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Companies.create_company(@valid_attrs)
      assert company.address_line_1 == "some address_line_1"
      assert company.name == "some name"
      assert company.postcode == "some postcode"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Companies.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, %Company{} = company} = Companies.update_company(company, @update_attrs)
      assert company.address_line_1 == "some updated address_line_1"
      assert company.name == "some updated name"
      assert company.postcode == "some updated postcode"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Companies.update_company(company, @invalid_attrs)
      assert company == Companies.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Companies.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Companies.change_company(company)
    end
  end

  describe "employees" do
    alias SauceTest.Companies.Employee

    @company_attrs %{
      "address_line_1" => "some address_line_1",
      "name" => "some name",
      "postcode" => "some postcode"
    }

    @valid_attrs %{
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
    @invalid_attrs %{"email" => nil, "first_name" => nil, "last_name" => nil, "started_at" => nil}

    def employee_fixture(attrs \\ %{}) do
      {:ok, company} = Companies.create_company(@company_attrs)

      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_employee(company)

      employee
    end

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Companies.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Companies.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      {:ok, company} = Companies.create_company(@company_attrs)
      assert {:ok, %Employee{} = employee} = Companies.create_employee(@valid_attrs, company)

      assert employee.email == "some email"
      assert employee.first_name == "some first_name"
      assert employee.last_name == "some last_name"
      assert employee.started_at == ~D[2010-04-17]
    end

    test "create_employee/1 with invalid data returns error changeset" do
      {:ok, company} = Companies.create_company(@company_attrs)
      assert {:error, %Ecto.Changeset{}} = Companies.create_employee(@invalid_attrs, company)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{} = employee} = Companies.update_employee(employee, @update_attrs)
      assert employee.email == "some updated email"
      assert employee.first_name == "some updated first_name"
      assert employee.last_name == "some updated last_name"
      assert employee.started_at == ~D[2011-05-18]
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Companies.update_employee(employee, @invalid_attrs)
      assert employee == Companies.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Companies.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Companies.change_employee(employee)
    end
  end
end
