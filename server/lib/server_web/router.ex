defmodule ServerWeb.Router do
  use ServerWeb, :router
  alias Server.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api/v1", ServerWeb do
    pipe_through :api

    post "/patients/sign_up", PatientController, :create
    post "/patients/sign_in", PatientController, :sign_in
    post "/staff/sign_up", EmployeeController, :create
    post "/staff/sign_in", EmployeeController, :sign_in
  end

  scope "/api/v1", ServerWeb do
    pipe_through [:api, :jwt_authenticated]
    
    resources "/patients", PatientController, only: [:show, :update]
    resources "/staff", EmployeeController, only: [:show, :update]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ServerWeb.Telemetry
    end
  end
end
