defmodule ServerWeb.EmployeeController do
  use ServerWeb, :controller

  alias Server.Accounts
  alias Server.Accounts.Employee

  action_fallback ServerWeb.FallbackController

  def index(conn, _params) do
    employees = Accounts.list_employees()
    render(conn, "index.json", employees: employees)
  end

  def create(conn, %{"employee" => employee_params}) do
    with {:ok, %Employee{} = employee} <- Accounts.create_employee(employee_params),
    {:ok, token, _claims} <- Server.Guardian.encode_and_sign(employee) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.patient_path(conn, :show, employee))
      |> render("jwt.json", jwt: token)
    end
  end

  def sign_in(conn, %{"reg" => reg, "password" => password}) do
    case Accounts.employee_token_sign_in(reg, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end

  def show(conn, _params) do
    employee = Guardian.Plug.current_resource(conn)
    conn |> render("show.json", employee: employee)
 end

  def update(conn, %{"id" => id, "employee" => employee_params}) do
    employee = Accounts.get_employee!(id)

    with {:ok, %Employee{} = employee} <- Accounts.update_employee(employee, employee_params) do
      render(conn, "show.json", employee: employee)
    end
  end

  def delete(conn, %{"id" => id}) do
    employee = Accounts.get_employee!(id)

    with {:ok, %Employee{}} <- Accounts.delete_employee(employee) do
      send_resp(conn, :no_content, "")
    end
  end
end
