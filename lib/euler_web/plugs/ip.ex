defmodule Euler.Plugs.IP do
  import Plug.Conn

  @doc false
  def init(default), do: default

  def call(conn, _opts) do
    # TODO create or get user by ip
    conn
    |> parse_ip()
    |> assign(:current_user, %{id: 1})
  end

  defp parse_ip(conn) do
    ip = conn.remote_ip |> :inet_parse.ntoa() |> to_string()
    put_private(conn, :current_ip, ip)
  end
end
