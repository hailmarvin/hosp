defmodule Server.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :title, :string
      add :date, :string

      timestamps()
    end

  end
end
