defmodule Hosp.Accounts.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :age, :integer
    field :firstname, :string
    field :gender, :string
    field :surname, :string
    field :email, :string
    field :phone, :integer
    field :password, :string, virtual: true # We need to add this row
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:firstname, :surname, :age, :gender, :password, :email, :phone])
    |> validate_required([:firstname, :surname, :age, :gender, :password, :email, :phone])
    |> validate_changeset
  end

  # def registration_changeset(patient, params \\ %{}) do
  #   patient
  #   |> cast(params, [:email, :name, :phone, :password])
  #   |> validate_required([:email, :name, :phone, :password])
  #   |> validate_changeset
  # end

  defp validate_changeset(struct) do
    struct
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:phone, min: 9, max: 10)
    |> validate_length(:password, min: 8)
    |> validate_format(:password, ~r/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*/, [message: "Must include at least one lowercase letter, one uppercase letter, and one digit"])
    |> generate_password_hash
  end

  defp generate_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
