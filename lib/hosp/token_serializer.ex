defmodule Hosp.GuardianSerializer do
    @behaviour Guardian.Serializer
  
    alias Hosp.Repo
    alias Hosp.Accounts
  
    def for_token(user = %Accounts.Patient{}), do: { :ok, "Patient:#{patient.id}" }
    # def for_token(user = %Accounts.Staff{}), do: { :ok, "Staff:#{staff.id}" }
    def for_token(_), do: { :error, "Unknown resource type" }
  
    # def from_token("Staff:" <> id), do: { :ok, Repo.get(Accounts.Staff, id) }
    def from_token("Patient:" <> id), do: { :ok, Repo.get(Accounts.Patient, id) }
    def from_token(_), do: { :error, "Unknown resource type" }
  end