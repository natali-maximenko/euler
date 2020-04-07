defmodule EulerWeb.SessionController do
  use EulerWeb, :controller

  alias Euler.Administration.{Accounts, Accounts.Admin, Accounts.Auth, Accounts.Guardian.Plug}

  def new(conn, _) do
    changeset = Accounts.change_admin(%Admin{})
    maybe_admin = Plug.current_resource(conn)

    if maybe_admin do
      redirect(conn, to: "/protected")
    else
      render(conn, "new.html", changeset: changeset, action: Routes.session_path(conn, :login))
    end
  end

  def login(conn, %{"admin" => %{"email" => email, "password" => password}}) do
    response = Auth.authenticate(email, password)
    login_reply(response, conn)
  end

  def logout(conn, _) do
    conn
    |> Plug.sign_out()
    |> redirect(to: "/login")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:info, "Welcome back!")
    |> Plug.sign_in(user)
    |> assign(:current_user, user)
    |> redirect(to: "/protected")
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end
