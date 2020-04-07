defmodule EulerWeb.PageController do
  use EulerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def protected(conn, _) do
    admin = Guardian.Plug.current_resource(conn)
    render(conn, "protected.html", current_admin: admin)
  end
end
