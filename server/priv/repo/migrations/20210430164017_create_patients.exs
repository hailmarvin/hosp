defmodule Server.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :name, :string
      add :surname, :string
      add :phone, :integer
      add :reg, :integer
      add :dob, :date
      add :email, :string
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:patients, [:email, :phone, :reg])
  end
end
