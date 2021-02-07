defmodule SauceTest.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string, null: false
      add :address_line_1, :string
      add :postcode, :string, null: false

      timestamps()
    end

  end
end
