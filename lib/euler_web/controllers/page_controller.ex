defmodule EulerWeb.PageController do
  use EulerWeb, :controller
  alias Guardian.Plug

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def protected(conn, _) do
    admin = Plug.current_resource(conn)
    render(conn, "protected.html", current_admin: admin)
  end
end
