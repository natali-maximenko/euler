defmodule EulerWeb.CheckupChannel do
  use Phoenix.Channel

  def join("checkups:user_" <> user_id, _params, socket) do
    {user_id, _} = Integer.parse(user_id)

    case socket.assigns.user_id == user_id do
      true -> {:ok, socket}
      false -> {:error, %{socket: socket.assigns, user_id: user_id}}
    end
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    now = DateTime.utc_now()
    now = now |> to_string() |> String.slice(0..-12)
    broadcast!(socket, "new_msg", %{body: "[#{now}] #{body}"})
    {:noreply, socket}
  end
end
