defmodule ServerWeb.EmployeeControllerTest do
  use ServerWeb.ConnCase

  alias Server.Accounts
  alias Server.Accounts.Employee

  @create_attrs %{
    department: "some department",
    dob: ~D[2010-04-17],
    email: "some email",
    isadmin: true,
    name: "some name",
    password_hash: "some password_hash",
    phone: 42,
    position: "some position",
    reg: 42,
    surname: "some surname"
  }
  @update_attrs %{
    department: "some updated department",
    dob: ~D[2011-05-18],
    email: "some updated email",
    isadmin: false,
    name: "some updated name",
    password_hash: "some updated password_hash",
    phone: 43,
    position: "some updated position",
    reg: 43,
    surname: "some updated surname"
  }
  @invalid_attrs %{department: nil, dob: nil, email: nil, isadmin: nil, name: nil, password_hash: nil, phone: nil, position: nil, reg: nil, surname: nil}

  def fixture(:employee) do
    {:ok, employee} = Accounts.create_employee(@create_attrs)
    employee
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all employees", %{conn: conn} do
      conn = get(conn, Routes.employee_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create employee" do
    test "renders employee when data is valid", %{conn: conn} do
      conn = post(conn, Routes.employee_path(conn, :create), employee: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.employee_path(conn, :show, id))

      assert %{
               "id" => id,
               "department" => "some department",
               "dob" => "2010-04-17",
               "email" => "some email",
               "isadmin" => true,
               "name" => "some name",
               "password_hash" => "some password_hash",
               "phone" => 42,
               "position" => "some position",
               "reg" => 42,
               "surname" => "some surname"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.employee_path(conn, :create), employee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update employee" do
    setup [:create_employee]

    test "renders employee when data is valid", %{conn: conn, employee: %Employee{id: id} = employee} do
      conn = put(conn, Routes.employee_path(conn, :update, employee), employee: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.employee_path(conn, :show, id))

      assert %{
               "id" => id,
               "department" => "some updated department",
               "dob" => "2011-05-18",
               "email" => "some updated email",
               "isadmin" => false,
               "name" => "some updated name",
               "password_hash" => "some updated password_hash",
               "phone" => 43,
               "position" => "some updated position",
               "reg" => 43,
               "surname" => "some updated surname"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, employee: employee} do
      conn = put(conn, Routes.employee_path(conn, :update, employee), employee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete employee" do
    setup [:create_employee]

    test "deletes chosen employee", %{conn: conn, employee: employee} do
      conn = delete(conn, Routes.employee_path(conn, :delete, employee))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.employee_path(conn, :show, employee))
      end
    end
  end

  defp create_employee(_) do
    employee = fixture(:employee)
    %{employee: employee}
  end
end
