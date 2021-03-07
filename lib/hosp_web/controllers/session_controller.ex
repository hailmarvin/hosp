defmodule HospWeb.SessionController do
  use HospWeb, :controller
  
  alias Hosp.Accounts
  
  def sign_in(conn, %{"session" => %{"email" => email, "password" => password}}) do  
    case Accounts.find_and_confirm_password(email, password) do
      {:ok, patient} ->
        {:ok, jwt, _full_claims} = Guardian.encode_and_sign(patient, :api)
        
        conn
        |> render("sign_in.json", patient: patient, jwt: jwt)

      {:error, _reason} ->
          conn
          |> put_status(401)
          |> render("error.json", message: "Could not login")
    end
  end  
end