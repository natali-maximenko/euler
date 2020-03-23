defmodule EulerWeb.TaxesController do
  use EulerWeb, :controller
  alias Euler.Taxes

  def index(conn, _params) do
    changeset = Taxes.build_checkup()
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

      # TODO fallback controller
      # {:error, msg} ->
      #   conn
      #   |> put_flash(:info, msg)
      #   |> redirect(to: "/")
    end
  end

  defp result_msg(true), do: "ITN valid!"
  defp result_msg(false), do: "ITN invalid!"

  defp build_checkup(conn, itn, validation_result) do
    %{
      itn: itn,
      ip: ip_to_string(conn.remote_ip),
      user_agent: user_agent(conn.req_headers),
      valid: validation_result
    }
  end

  # TODO Ecto type ip
  defp ip_to_string(ip) when is_tuple(ip) do
    ip |> :inet_parse.ntoa() |> to_string()
  end

  defp ip_to_string(ip), do: {:error, ip}

  defp user_agent(headers) do
    headers
    |> Enum.find(fn {key, _} -> key == "user-agent" end)
    |> elem(1)
  end
end
