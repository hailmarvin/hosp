defmodule Hosp.AccountsTest do
  use Hosp.DataCase

  alias Hosp.Accounts

  describe "patients" do
    alias Hosp.Accounts.Patient

    @valid_attrs %{age: 42, firstname: "some firstname", gender: "some gender", surname: "some surname"}
    @update_attrs %{age: 43, firstname: "some updated firstname", gender: "some updated gender", surname: "some updated surname"}
    @invalid_attrs %{age: nil, firstname: nil, gender: nil, surname: nil}

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
      assert patient.age == 42
      assert patient.firstname == "some firstname"
      assert patient.gender == "some gender"
      assert patient.surname == "some surname"
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{} = patient} = Accounts.update_patient(patient, @update_attrs)
      assert patient.age == 43
      assert patient.firstname == "some updated firstname"
      assert patient.gender == "some updated gender"
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

  describe "staffs" do
    alias Hosp.Accounts.Staff

    @valid_attrs %{department: "some department", gender: "some gender", name: "some name", position: "some position", registration: 42}
    @update_attrs %{department: "some updated department", gender: "some updated gender", name: "some updated name", position: "some updated position", registration: 43}
    @invalid_attrs %{department: nil, gender: nil, name: nil, position: nil, registration: nil}

    def staff_fixture(attrs \\ %{}) do
      {:ok, staff} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_staff()

      staff
    end

    test "list_staffs/0 returns all staffs" do
      staff = staff_fixture()
      assert Accounts.list_staffs() == [staff]
    end

    test "get_staff!/1 returns the staff with given id" do
      staff = staff_fixture()
      assert Accounts.get_staff!(staff.id) == staff
    end

    test "create_staff/1 with valid data creates a staff" do
      assert {:ok, %Staff{} = staff} = Accounts.create_staff(@valid_attrs)
      assert staff.department == "some department"
      assert staff.gender == "some gender"
      assert staff.name == "some name"
      assert staff.position == "some position"
      assert staff.registration == 42
    end

    test "create_staff/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_staff(@invalid_attrs)
    end

    test "update_staff/2 with valid data updates the staff" do
      staff = staff_fixture()
      assert {:ok, %Staff{} = staff} = Accounts.update_staff(staff, @update_attrs)
      assert staff.department == "some updated department"
      assert staff.gender == "some updated gender"
      assert staff.name == "some updated name"
      assert staff.position == "some updated position"
      assert staff.registration == 43
    end

    test "update_staff/2 with invalid data returns error changeset" do
      staff = staff_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_staff(staff, @invalid_attrs)
      assert staff == Accounts.get_staff!(staff.id)
    end

    test "delete_staff/1 deletes the staff" do
      staff = staff_fixture()
      assert {:ok, %Staff{}} = Accounts.delete_staff(staff)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_staff!(staff.id) end
    end

    test "change_staff/1 returns a staff changeset" do
      staff = staff_fixture()
      assert %Ecto.Changeset{} = Accounts.change_staff(staff)
    end
  end
end
