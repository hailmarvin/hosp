defmodule HospWeb.StaffController do
  use HospWeb, :controller

  alias Hosp.Accounts
  alias Hosp.Accounts.Staff

  action_fallback HospWeb.FallbackController

  def index(conn, _params) do
    staffs = Accounts.list_staffs()
    render(conn, "index.json", staffs: staffs)
  end

  def create(conn, %{"staff" => staff_params}) do
    with {:ok, %Staff{} = staff} <- Accounts.create_staff(staff_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.staff_path(conn, :show, staff))
      |> render("show.json", staff: staff)
    end
  end

  def show(conn, %{"id" => id}) do
    staff = Accounts.get_staff!(id)
    render(conn, "show.json", staff: staff)
  end

  def update(conn, %{"id" => id, "staff" => staff_params}) do
    staff = Accounts.get_staff!(id)

    with {:ok, %Staff{} = staff} <- Accounts.update_staff(staff, staff_params) do
      render(conn, "show.json", staff: staff)
    end
  end

  def delete(conn, %{"id" => id}) do
    staff = Accounts.get_staff!(id)

    with {:ok, %Staff{}} <- Accounts.delete_staff(staff) do
      send_resp(conn, :no_content, "")
    end
  end
end
