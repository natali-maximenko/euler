defmodule EulerWeb.CheckupChannel do
  use Phoenix.Channel
  alias Euler.Taxes

  def join("checkups:user_" <> user_id, _params, socket) do
    {user_id, _} = Integer.parse(user_id)

    case socket.assigns.user_id == user_id do
      true -> {:ok, socket}
      false -> {:error, %{socket: socket.assigns, user_id: user_id}}
    end
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    now = DateTime.utc_now() |> to_string() |> String.slice(0..-9)
    {:ok, result} = Taxes.verify_itn(body)
    attrs = build_checkup(body, result)
    {:ok, _checkup} = Taxes.create_checkup(attrs)
    broadcast!(socket, "new_msg", %{body: "[#{now}] #{body} : #{result}"})
    {:noreply, socket}
  end

  defp build_checkup(itn, validation_result) do
    %{
      itn: itn,
      ip: "127.0.0.1",
      user_agent: "user_agent",
      valid: validation_result
    }
  end
end
