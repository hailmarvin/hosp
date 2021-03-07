defmodule HospWeb.RegistrationController do
    use HospWeb, :controller
  
    alias Hosp.Accounts.Patient
    alias Hosp.Repo
  
    def sign_up(conn, %{"patient" => patient_params}) do
      changeset = Patient.changeset(%Patient{}, patient_params)
  
      case Repo.insert(changeset) do
        {:ok, patient} ->
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.patient_path(conn, :show, patient))
          |> render("success.json", patient: patient)
        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(HospWeb.ChangesetView, "error.json", changeset: changeset)
      end
    end
  end