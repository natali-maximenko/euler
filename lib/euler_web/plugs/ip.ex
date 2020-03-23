defmodule Euler.Plugs.IP do
  import Plug.Conn

  @doc false
  def init(default), do: default

  def call(conn, _opts) do
    parse_ip(conn)
  end

  defp parse_ip(conn) do
    ip = conn.remote_ip |> :inet_parse.ntoa() |> to_string()
    put_private(conn, :current_ip, ip)
  end
end
