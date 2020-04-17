defmodule EulerWeb.Router do
  use EulerWeb, :router
  alias Phoenix.Token

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Euler.Plugs.IP
    plug :put_user_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Euler.Administration.Accounts.Guardian.Pipeline
  end

  # We use ensure_auth to fail if there is no one logged in
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", EulerWeb do
    pipe_through :browser

    get "/page", PageController, :index
    get "/", TaxesController, :index
    post "/check_itn", TaxesController, :check_itn

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
  end

  # Definitely logged in scope
  scope "/", EulerWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/protected", PageController, :protected
    resources "/checkups", Administration.CheckupController, only: [:index, :delete]
    put "/users/block/:user_id", Administration.UserController, :block
    put "/users/unblock/:user_id", Administration.UserController, :unblock
  end

  # Other scopes may use custom stacks.
  # scope "/api", EulerWeb do
  #   pipe_through :api
  # end

  defp put_user_token(conn, _) do
    if user = conn.assigns[:user] do
      token = Token.sign(conn, "user socket", user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end
end
