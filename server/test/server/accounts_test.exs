defmodule Server.AccountsTest do
  use Server.DataCase

  alias Server.Accounts

  describe "patients" do
    alias Server.Accounts.Patient

    @valid_attrs %{dob: ~D[2010-04-17], email: "some email", name: "some name", password_hash: "some password_hash", phone: 42, reg: 42, surname: "some surname"}
    @update_attrs %{dob: ~D[2011-05-18], email: "some updated email", name: "some updated name", password_hash: "some updated password_hash", phone: 43, reg: 43, surname: "some updated surname"}
    @invalid_attrs %{dob: nil, email: nil, name: nil, password_hash: nil, phone: nil, reg: nil, surname: nil}

    def patient_fixture(attrs \\ %{}) do
      {:ok, patient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_patient()

      patient
    end

    test "list_patients/0 returns all patients" do
      patient = patient_fixture()
      assert Accounts.list_patients() == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = patient_fixture()
      assert Accounts.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      assert {:ok, %Patient{} = patient} = Accounts.create_patient(@valid_attrs)
      assert patient.dob == ~D[2010-04-17]
      assert patient.email == "some email"
      assert patient.name == "some name"
      assert patient.password_hash == "some password_hash"
      assert patient.phone == 42
      assert patient.reg == 42
      assert patient.surname == "some surname"
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{} = patient} = Accounts.update_patient(patient, @update_attrs)
      assert patient.dob == ~D[2011-05-18]
      assert patient.email == "some updated email"
      assert patient.name == "some updated name"
      assert patient.password_hash == "some updated password_hash"
      assert patient.phone == 43
      assert patient.reg == 43
      assert patient.surname == "some updated surname"
    end

    test "update_patient/2 with invalid data returns error changeset" do
      patient = patient_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_patient(patient, @invalid_attrs)
      assert patient == Accounts.get_patient!(patient.id)
    end

    test "delete_patient/1 deletes the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{}} = Accounts.delete_patient(patient)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_patient!(patient.id) end
    end

    test "change_patient/1 returns a patient changeset" do
      patient = patient_fixture()
      assert %Ecto.Changeset{} = Accounts.change_patient(patient)
    end
  end

  describe "employees" do
    alias Server.Accounts.Employee

    @valid_attrs %{department: "some department", dob: ~D[2010-04-17], email: "some email", isadmin: true, name: "some name", password_hash: "some password_hash", phone: 42, position: "some position", reg: 42, surname: "some surname"}
    @update_attrs %{department: "some updated department", dob: ~D[2011-05-18], email: "some updated email", isadmin: false, name: "some updated name", password_hash: "some updated password_hash", phone: 43, position: "some updated position", reg: 43, surname: "some updated surname"}
    @invalid_attrs %{department: nil, dob: nil, email: nil, isadmin: nil, name: nil, password_hash: nil, phone: nil, position: nil, reg: nil, surname: nil}

    def employee_fixture(attrs \\ %{}) do
      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_employee()

      employee
    end

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Accounts.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Accounts.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      assert {:ok, %Employee{} = employee} = Accounts.create_employee(@valid_attrs)
      assert employee.department == "some department"
      assert employee.dob == ~D[2010-04-17]
      assert employee.email == "some email"
      assert employee.isadmin == true
      assert employee.name == "some name"
      assert employee.password_hash == "some password_hash"
      assert employee.phone == 42
      assert employee.position == "some position"
      assert employee.reg == 42
      assert employee.surname == "some surname"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{} = employee} = Accounts.update_employee(employee, @update_attrs)
      assert employee.department == "some updated department"
      assert employee.dob == ~D[2011-05-18]
      assert employee.email == "some updated email"
      assert employee.isadmin == false
      assert employee.name == "some updated name"
      assert employee.password_hash == "some updated password_hash"
      assert employee.phone == 43
      assert employee.position == "some updated position"
      assert employee.reg == 43
      assert employee.surname == "some updated surname"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_employee(employee, @invalid_attrs)
      assert employee == Accounts.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Accounts.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Accounts.change_employee(employee)
    end
  end
end
