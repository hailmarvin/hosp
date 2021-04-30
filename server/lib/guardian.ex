defmodule Server.Guardian do
    use Guardian, otp_app: :server
  
    def user_subject_for_token(user, _claims) do
      sub = to_string(user.id)
      {:ok, sub}
    end
  
    def user_subject_for_token(_, _) do
      {:error, :reason_for_error}
    end
  
    def user_resource_from_claims(claims) do
      id = claims["sub"]
      resource = Server.Accounts.get_patient!(id)
      {:ok,  resource}
    end
  
    def user_resource_from_claims(_claims) do
      {:error, :reason_for_error}
    end

    def employee_subject_for_token(employee, _claims) do
      sub = to_string(employee.id)
      {:ok, sub}
    end
    
    def employee_subject_for_token(_, _) do
      {:error, :reason_for_error}
    end
    
    def employee_resource_from_claims(claims) do
      id = claims["sub"]
      resource = Server.Accounts.get_employee!(id)
      {:ok,  resource}
    end
    
    def employee_resource_from_claims(_claims) do
      {:error, :reason_for_error}
    end
  end