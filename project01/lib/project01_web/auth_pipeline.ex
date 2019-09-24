defmodule Project01.Guardian.AuthPipeline do
    use Guardian.Plug.Pipeline, otp_app: :project01,
    module: Project01.Guardian,
    error_handler: Project01.AuthErrorHandler
  
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end