defmodule ServerWeb.PatientView do
  use ServerWeb, :view
  alias ServerWeb.PatientView

  def render("index.json", %{patients: patients}) do
    %{data: render_many(patients, PatientView, "patient.json")}
  end

  def render("show.json", %{patient: patient}) do
    %{data: render_one(patient, PatientView, "patient.json")}
  end

  def render("patient.json", %{patient: patient}) do
    %{id: patient.id,
      name: patient.name,
      surname: patient.surname,
      phone: patient.phone,
      reg: patient.reg,
      dob: patient.dob,
      email: patient.email,
      password_hash: patient.password_hash}
  end
end
