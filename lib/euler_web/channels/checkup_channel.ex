defmodule EulerWeb.CheckupChannel do
  use Phoenix.Channel
  alias Euler.Taxes
  alias EulerWeb.TaxesView

  def join("checkups:user_" <> user_id, _params, socket) do
    {user_id, _} = Integer.parse(user_id)

    case socket.assigns.user_id == user_id do
      true -> {:ok, socket}
      false -> {:error, %{socket: socket.assigns, user_id: user_id}}
    end
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    {:ok, result} = Taxes.verify_itn(body)
    attrs = %{itn: body, user_id: socket.assigns.user_id, valid: result}
    {:ok, _checkup} = Taxes.create_checkup(attrs)

    json = TaxesView.render("checkup.json", %{itn: body, result: result})
    broadcast!(socket, "new_msg", json)
    {:noreply, socket}
  end
end
