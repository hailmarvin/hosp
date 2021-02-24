defmodule Hosp.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :firstname, :string
      add :surname, :string
      add :age, :integer
      add :gender, :string

      timestamps()
    end

  end
end
