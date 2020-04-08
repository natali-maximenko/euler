defmodule EulerWeb.Administration.UserController do
  use EulerWeb, :controller
  alias Euler.Accounts

  def block(conn, %{"user_id" => id}) do
    with user <- Accounts.get_user!(id),
         {:ok, _} <- Accounts.block_user(user) do
      conn
      |> put_flash(:info, "User with ip: #{user.ip} blocked")
      |> redirect(to: "/checkups")
    end
  end

  def unblock(conn, %{"user_id" => id}) do
    with user <- Accounts.get_user!(id),
         {:ok, _} <- Accounts.unblock_user(user) do
      conn
      |> put_flash(:info, "User with ip: #{user.ip} unblocked")
      |> redirect(to: "/checkups")
    end
  end
end
