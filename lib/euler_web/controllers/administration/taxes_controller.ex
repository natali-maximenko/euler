defmodule EulerWeb.Administration.TaxesController do
  use EulerWeb, :controller
  alias Euler.Taxes

  action_fallback EulerWeb.FallbackController

  def index(conn, _params) do
    list = Taxes.list_checkups()
    render(conn, "index.html", list: list)
  end
end
