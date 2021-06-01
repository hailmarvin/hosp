defmodule ServerWeb.AppointmentController do
  use ServerWeb, :controller

  alias Server.Accounts
  alias Server.Accounts.Appointment

  action_fallback ServerWeb.FallbackController

  def index(conn, _params) do
    appointments = Accounts.list_appointments()
    render(conn, "index.json", appointments: appointments)
  end

  def create(conn, %{"appointment" => appointment_params}) do
    with {:ok, %Appointment{} = appointment} <- Accounts.create_appointment(appointment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.appointment_path(conn, :show, appointment))
      |> render("show.json", appointment: appointment)
    end
  end

  def show(conn, %{"id" => id}) do
    appointment = Accounts.get_appointment!(id)
    render(conn, "show.json", appointment: appointment)
  end

  def update(conn, %{"id" => id, "appointment" => appointment_params}) do
    appointment = Accounts.get_appointment!(id)

    with {:ok, %Appointment{} = appointment} <- Accounts.update_appointment(appointment, appointment_params) do
      render(conn, "show.json", appointment: appointment)
    end
  end

  def delete(conn, %{"id" => id}) do
    appointment = Accounts.get_appointment!(id)

    with {:ok, %Appointment{}} <- Accounts.delete_appointment(appointment) do
      send_resp(conn, :no_content, "")
    end
  end
end
