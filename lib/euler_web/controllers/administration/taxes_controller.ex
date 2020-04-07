defmodule EulerWeb.Administration.TaxesController do
  use EulerWeb, :controller
  alias Euler.Taxes
  alias Guardian.Plug

  action_fallback EulerWeb.FallbackController

  def index(conn, _params) do
    admin = Plug.current_resource(conn)
    list = Taxes.list_checkups()
    render(conn, "index.html", list: list, current_admin: admin)
  end
end
