defmodule ServerWeb.PatientController do
  use ServerWeb, :controller

  alias Server.Accounts
  alias Server.Accounts.Patient

  action_fallback ServerWeb.FallbackController

  def index(conn, _params) do
    patients = Accounts.list_patients()
    render(conn, "index.json", patients: patients)
  end

  def create(conn, %{"patient" => patient_params}) do
    with {:ok, %Patient{} = patient} <- Accounts.create_patient(patient_params),
    {:ok, token, _claims} <- Server.Guardian.encode_and_sign(patient) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.patient_path(conn, :show, patient))
      |> render("jwt.json", jwt: token)
    end
  end

  def sign_in(conn, %{"reg" => reg, "password" => password}) do
    case Accounts.patient_token_sign_in(reg, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end

  def show(conn, _params) do
    patient = Guardian.Plug.current_resource(conn)
    conn |> render("show.json", patient: patient)
 end

  def update(conn, %{"id" => id, "patient" => patient_params}) do
    patient = Accounts.get_patient!(id)

    with {:ok, %Patient{} = patient} <- Accounts.update_patient(patient, patient_params) do
      render(conn, "show.json", patient: patient)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient = Accounts.get_patient!(id)

    with {:ok, %Patient{}} <- Accounts.delete_patient(patient) do
      send_resp(conn, :no_content, "")
    end
  end
end
