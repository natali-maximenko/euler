defmodule EulerWeb.TaxesController do
  use EulerWeb, :controller
  alias Euler.Taxes

  def index(conn, _params) do
    changeset = Taxes.change_itn()
    render(conn, "index.html", changeset: changeset)
  end

  def check_itn(conn, %{"form" => form_params}) do
    case Taxes.verify_itn(form_params["itn"]) do
      {:ok, true} ->
        conn
        |> put_flash(:info, "ITN valid!")
        |> redirect(to: "/")

      {:ok, false} ->
        conn
        |> put_flash(:info, "ITN invalid!")
        |> redirect(to: "/")

      {:error, msg} ->
        conn
        |> put_flash(:info, msg)
        |> redirect(to: "/")
    end
  end
end
