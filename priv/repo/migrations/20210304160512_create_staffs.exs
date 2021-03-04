defmodule Hosp.Repo.Migrations.CreateStaffs do
  use Ecto.Migration

  def change do
    create table(:staffs) do
      add :name, :string
      add :department, :string
      add :registration, :integer
      add :gender, :string
      add :position, :string

      timestamps()
    end

  end
end
