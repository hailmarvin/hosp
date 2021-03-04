defmodule HospWeb.StaffView do
  use HospWeb, :view
  alias HospWeb.StaffView

  def render("index.json", %{staffs: staffs}) do
    %{data: render_many(staffs, StaffView, "staff.json")}
  end

  def render("show.json", %{staff: staff}) do
    %{data: render_one(staff, StaffView, "staff.json")}
  end

  def render("staff.json", %{staff: staff}) do
    %{id: staff.id,
      name: staff.name,
      department: staff.department,
      registration: staff.registration,
      gender: staff.gender,
      position: staff.position}
  end
end
