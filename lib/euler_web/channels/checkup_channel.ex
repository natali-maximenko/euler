defmodule EulerWeb.CheckupChannel do
  use EulerWeb, :channel

  alias Euler.Accounts
  alias Euler.Taxes
  alias EulerWeb.TaxesView

  def join("checkups:user_" <> user_id, _params, socket) do
    {user_id, _} = Integer.parse(user_id)

    case socket.assigns.user_id == user_id do
      true -> {:ok, socket}
      false -> {:error, %{socket: socket.assigns, user_id: user_id}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    user = Accounts.get_user!(socket.assigns.user_id)

    json =
      case Accounts.can_verify?(user) do
        {:ok, _} ->
          {:ok, result} = Taxes.verify_itn(body)
          attrs = %{itn: body, user_id: socket.assigns.user_id, valid: result}
          {:ok, _checkup} = Taxes.create_checkup(attrs)

          TaxesView.render("checkup.json", %{itn: body, result: result})

        {:error, msg} ->
          TaxesView.render("error.json", %{msg: msg})
      end

    broadcast!(socket, "new_msg", json)
    {:noreply, socket}
  end
end
