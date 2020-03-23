defmodule EulerWeb.Router do
  use EulerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Euler.Plugs.IP
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EulerWeb do
    pipe_through :browser

    get "/page", PageController, :index
    get "/", TaxesController, :index
    post "/check_itn", TaxesController, :check_itn
  end

  # Other scopes may use custom stacks.
  # scope "/api", EulerWeb do
  #   pipe_through :api
  # end
end
