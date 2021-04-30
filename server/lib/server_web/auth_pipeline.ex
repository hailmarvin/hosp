defmodule Server.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :Server,
  module: Server.Guardian,
  error_handler: Server.AuthErrorHandler
  
  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end