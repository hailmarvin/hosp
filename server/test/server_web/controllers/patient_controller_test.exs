defmodule ServerWeb.PatientControllerTest do
  use ServerWeb.ConnCase

  alias Server.Accounts
  alias Server.Accounts.Patient

  @create_attrs %{
    dob: ~D[2010-04-17],
    email: "some email",
    name: "some name",
    password_hash: "some password_hash",
    phone: 42,
    reg: 42,
    surname: "some surname"
  }
  @update_attrs %{
    dob: ~D[2011-05-18],
    email: "some updated email",
    name: "some updated name",
    password_hash: "some updated password_hash",
    phone: 43,
    reg: 43,
    surname: "some updated surname"
  }
  @invalid_attrs %{dob: nil, email: nil, name: nil, password_hash: nil, phone: nil, reg: nil, surname: nil}

  def fixture(:patient) do
    {:ok, patient} = Accounts.create_patient(@create_attrs)
    patient
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all patients", %{conn: conn} do
      conn = get(conn, Routes.patient_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create patient" do
    test "renders patient when data is valid", %{conn: conn} do
      conn = post(conn, Routes.patient_path(conn, :create), patient: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.patient_path(conn, :show, id))

      assert %{
               "id" => id,
               "dob" => "2010-04-17",
               "email" => "some email",
               "name" => "some name",
               "password_hash" => "some password_hash",
               "phone" => 42,
               "reg" => 42,
               "surname" => "some surname"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.patient_path(conn, :create), patient: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update patient" do
    setup [:create_patient]

    test "renders patient when data is valid", %{conn: conn, patient: %Patient{id: id} = patient} do
      conn = put(conn, Routes.patient_path(conn, :update, patient), patient: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.patient_path(conn, :show, id))

      assert %{
               "id" => id,
               "dob" => "2011-05-18",
               "email" => "some updated email",
               "name" => "some updated name",
               "password_hash" => "some updated password_hash",
               "phone" => 43,
               "reg" => 43,
               "surname" => "some updated surname"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, patient: patient} do
      conn = put(conn, Routes.patient_path(conn, :update, patient), patient: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete patient" do
    setup [:create_patient]

    test "deletes chosen patient", %{conn: conn, patient: patient} do
      conn = delete(conn, Routes.patient_path(conn, :delete, patient))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.patient_path(conn, :show, patient))
      end
    end
  end

  defp create_patient(_) do
    patient = fixture(:patient)
    %{patient: patient}
  end
end
