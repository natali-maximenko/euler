defmodule EulerWeb.TaxesController do
  use EulerWeb, :controller
  alias Euler.Accounts
  alias Euler.Taxes

  action_fallback EulerWeb.FallbackController

  def index(conn, _params) do
    changeset = Taxes.change_checkup()
    # list return only my checkups
    list = Taxes.list_checkups(conn.private[:current_ip])
    render(conn, "index.html", changeset: changeset, list: list)
  end

  def check_itn(conn, %{"form" => form_params}) do
    with {:ok, result} <- Taxes.verify_itn(form_params["itn"]),
         attrs <- build_checkup(conn, form_params["itn"], result),
         {:ok, _checkup} <- Taxes.create_checkup(attrs) do
      conn
      |> put_flash(:info, result_msg(result))
      |> redirect(to: "/")
    end
  end

  defp result_msg(true), do: "ITN valid!"
  defp result_msg(false), do: "ITN invalid!"

  defp build_checkup(conn, itn, validation_result) do
    user = conn.assigns[:user]

    %{
      itn: itn,
      user_id: user.id,
      valid: validation_result
    }
  end
end
