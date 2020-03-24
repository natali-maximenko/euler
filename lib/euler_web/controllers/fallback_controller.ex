defmodule EulerWeb.FallbackController do
  use EulerWeb, :controller
  alias EulerWeb.ErrorView

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(403)
    |> put_view(ErrorView)
    |> render(:"403")
  end

  def call(conn, {:error, msg}) do
    conn
    |> put_flash(:info, msg)
    |> redirect(to: "/")
  end
end
