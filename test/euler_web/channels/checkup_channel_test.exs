defmodule EulerWeb.CheckupChannelTest do
  use EulerWeb.ChannelCase
  import Euler.Factory

  alias EulerWeb.TaxesView

  setup do
    user = insert(:user)

    {:ok, _, socket} =
      socket(EulerWeb.UserSocket, "user_id", %{user_id: user.id})
      |> subscribe_and_join(EulerWeb.CheckupChannel, "checkups:user_#{user.id}")

    {:ok, socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push(socket, "ping", %{"hello" => "there"})
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "new_msg broadcasts to channel", %{socket: socket} do
    push(socket, "new_msg", %{"body" => "5610077532"})
    json_response = TaxesView.render("checkup.json", %{itn: "5610077532", result: true})
    assert_broadcast "new_msg", json_response
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "broadcast", %{"body" => "5610077532 : valid"})
    assert_push "broadcast", %{"body" => "5610077532 : valid"}
  end
end
