defmodule Server.Accounts.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    field :date, :string
    field :title, :string
    belongs_to :patient, Server.Accounts.Patient

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:title, :date])
    |> validate_required([:title, :date])
  end
end
