defmodule Server.Repo.Migrations.AppointmentsBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:appointments) do
      add :patient_id, references(:patients)
    end
  end
end
