defmodule HospWeb.PatientView do
  use HospWeb, :view
  alias HospWeb.PatientView

  def render("index.json", %{patients: patients}) do
    %{data: render_many(patients, PatientView, "patient.json")}
  end

  def render("show.json", %{patient: patient}) do
    %{data: render_one(patient, PatientView, "patient.json")}
  end

  def render("patient.json", %{patient: patient}) do
    %{id: patient.id,
      firstname: patient.firstname,
      surname: patient.surname,
      age: patient.age,
      gender: patient.gender}
  end
end
