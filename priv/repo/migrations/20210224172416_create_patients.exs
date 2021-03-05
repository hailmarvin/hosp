defmodule Hosp.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :firstname, :string
      add :surname, :string
      add :email, :string
      add :phone, :integer
      add :age, :integer
      add :gender, :string
      add :registration, :integer
      add :hash_password, :string

      timestamps()
    end

  end
end
