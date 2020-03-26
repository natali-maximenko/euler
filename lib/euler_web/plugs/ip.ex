defmodule Euler.Plugs.IP do
  import Plug.Conn
  alias Euler.Accounts

  @doc false
  def init(default), do: default

  def call(conn, _opts) do
    conn
    |> parse_ip()
    |> get_user()
  end

  defp parse_ip(conn) do
    ip = conn.remote_ip |> :inet_parse.ntoa() |> to_string()
    put_private(conn, :current_ip, ip)
    {conn, ip}
  end

  defp get_user({conn, ip}) do
    user =
      case Accounts.get_user_by(ip) do
        nil ->
          {:ok, user} = Accounts.create_user(%{ip: ip})
          user

        user ->
          user
      end

    assign(conn, :current_user, user)
  end
end
