defmodule EulerWeb.PageControllerTest do
  use EulerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/page")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
