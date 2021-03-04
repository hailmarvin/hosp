defmodule Hosp.Accounts.Staff do
  use Ecto.Schema
  import Ecto.Changeset

  schema "staffs" do
    field :department, :string
    field :gender, :string
    field :name, :string
    field :position, :string
    field :registration, :integer

    timestamps()
  end

  @doc false
  def changeset(staff, attrs) do
    staff
    |> cast(attrs, [:name, :department, :registration, :gender, :position])
    |> validate_required([:name, :department, :registration, :gender, :position])
  end
end
