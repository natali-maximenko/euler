defmodule EulerWeb.Administration.CheckupsController do
  use EulerWeb, :controller
  alias Euler.Taxes
  alias Guardian.Plug

  action_fallback EulerWeb.FallbackController

  def index(conn, _params) do
    admin = Plug.current_resource(conn)
    list = Taxes.list_checkups()
    render(conn, "index.html", list: list, current_admin: admin)
  end

  def delete(conn, %{"id" => id}) do
    with checkup <- Taxes.get_checkup(id),
         false <- is_nil(checkup) do
      {:ok, _} = Taxes.delete_checkup(checkup)

      conn
      |> put_flash(:info, "Checkup #{id} deleted")
      |> redirect(to: "/checkups")
    end
  end
end
