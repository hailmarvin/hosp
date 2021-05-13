defmodule Server.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :title, :string
      add :dob, :date
      add :active, :boolean
      add :employee_id, references(:employees)
    end
  end
end
