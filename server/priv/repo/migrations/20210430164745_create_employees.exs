defmodule Server.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :name, :string
      add :surname, :string
      add :phone, :integer
      add :reg, :integer
      add :dob, :string
      add :department, :string
      add :position, :string
      add :email, :string
      add :password_hash, :string
      add :isadmin, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:employees, [:email, :reg, :phone])
  end
end
