defmodule Hosp.Repo.Migrations.CreateStaffs do
  use Ecto.Migration

  def change do
    create table(:staffs) do
      add :name, :string
      add :surname, :string
      add :email, :string
      add :phone, :integer
      add :department, :string
      add :registration, :integer
      add :gender, :string
      add :position, :string
      add :hash_password, :string

      timestamps()
    end

  end
end
