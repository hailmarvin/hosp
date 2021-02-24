defmodule Hosp.Accounts.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :age, :integer
    field :firstname, :string
    field :gender, :string
    field :surname, :string

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:firstname, :surname, :age, :gender])
    |> validate_required([:firstname, :surname, :age, :gender])
  end
end
