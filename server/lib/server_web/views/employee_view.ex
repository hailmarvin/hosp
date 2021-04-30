defmodule ServerWeb.EmployeeView do
  use ServerWeb, :view
  alias ServerWeb.EmployeeView

  def render("index.json", %{employees: employees}) do
    %{data: render_many(employees, EmployeeView, "employee.json")}
  end

  def render("show.json", %{employee: employee}) do
    %{data: render_one(employee, EmployeeView, "employee.json")}
  end

  def render("employee.json", %{employee: employee}) do
    %{id: employee.id,
      name: employee.name,
      surname: employee.surname,
      phone: employee.phone,
      reg: employee.reg,
      dob: employee.dob,
      department: employee.department,
      position: employee.position,
      email: employee.email,
      password_hash: employee.password_hash,
      isadmin: employee.isadmin}
  end
end
