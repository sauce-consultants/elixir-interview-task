defmodule SauceTest.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias SauceTest.Companies.Employee

  schema "companies" do
    field :address_line_1, :string
    field :name, :string
    field :postcode, :string

    has_many :employees, Employee

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :address_line_1, :postcode])
    |> validate_required([:name, :address_line_1, :postcode])
  end
end
