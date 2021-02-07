defmodule SauceTest.Companies.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  alias SauceTest.Companies.Company

  schema "employees" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :started_at, :date

    belongs_to(:company, Company)

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) when is_map_key(attrs, "company") do
    employee
    |> cast(attrs, [:first_name, :last_name, :email, :started_at])
    |> validate_required([:first_name, :last_name, :email, :started_at])
    |> put_assoc(:company, attrs["company"])
  end

  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:first_name, :last_name, :email, :started_at])
    |> validate_required([:first_name, :last_name, :email, :started_at])
  end

  @doc false
  def update_changeset(employee, attrs) do
    employee
    |> cast(attrs, [:first_name, :last_name, :email, :started_at])
    |> validate_required([:first_name, :last_name, :email, :started_at])
  end
end
