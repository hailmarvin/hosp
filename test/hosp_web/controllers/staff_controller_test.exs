defmodule HospWeb.StaffControllerTest do
  use HospWeb.ConnCase

  alias Hosp.Accounts
  alias Hosp.Accounts.Staff

  @create_attrs %{
    department: "some department",
    gender: "some gender",
    name: "some name",
    position: "some position",
    registration: 42
  }
  @update_attrs %{
    department: "some updated department",
    gender: "some updated gender",
    name: "some updated name",
    position: "some updated position",
    registration: 43
  }
  @invalid_attrs %{department: nil, gender: nil, name: nil, position: nil, registration: nil}

  def fixture(:staff) do
    {:ok, staff} = Accounts.create_staff(@create_attrs)
    staff
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all staffs", %{conn: conn} do
      conn = get(conn, Routes.staff_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create staff" do
    test "renders staff when data is valid", %{conn: conn} do
      conn = post(conn, Routes.staff_path(conn, :create), staff: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.staff_path(conn, :show, id))

      assert %{
               "id" => id,
               "department" => "some department",
               "gender" => "some gender",
               "name" => "some name",
               "position" => "some position",
               "registration" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.staff_path(conn, :create), staff: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update staff" do
    setup [:create_staff]

    test "renders staff when data is valid", %{conn: conn, staff: %Staff{id: id} = staff} do
      conn = put(conn, Routes.staff_path(conn, :update, staff), staff: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.staff_path(conn, :show, id))

      assert %{
               "id" => id,
               "department" => "some updated department",
               "gender" => "some updated gender",
               "name" => "some updated name",
               "position" => "some updated position",
               "registration" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, staff: staff} do
      conn = put(conn, Routes.staff_path(conn, :update, staff), staff: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete staff" do
    setup [:create_staff]

    test "deletes chosen staff", %{conn: conn, staff: staff} do
      conn = delete(conn, Routes.staff_path(conn, :delete, staff))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.staff_path(conn, :show, staff))
      end
    end
  end

  defp create_staff(_) do
    staff = fixture(:staff)
    %{staff: staff}
  end
end
