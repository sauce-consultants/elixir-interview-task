defmodule SauceTest.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :started_at, :date
      add :company_id, references(:companies, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:employees, [:company_id])
  end
end
