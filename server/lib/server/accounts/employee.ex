defmodule Server.Accounts.Employee do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "employees" do
    field :department, :string
    field :dob, :string
    field :email, :string
    field :isadmin, :boolean, default: false
    field :name, :string
    field :password_hash, :string
    field :phone, :integer
    field :position, :string
    field :reg, :integer
    field :surname, :string
    # Virtual fields:
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:name, :surname, :phone, :reg, :dob, :department, :position, :email, :password, :password_confirmation, :isadmin])
    |> validate_required([:name, :surname, :phone, :reg, :dob, :department, :position, :email, :password, :password_confirmation, :isadmin])
    |> validate_format(:email, ~r/@/) # Check that email is valid
    |> validate_length(:password, min: 8) # Check that password length is >= 8 
    |> validate_confirmation(:password) # Check that password === password_confirmation
    |> unique_constraint([:email, :reg, :phone])
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
          changeset
    end
  end
end
