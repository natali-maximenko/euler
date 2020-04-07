defmodule Euler.Administration.Accounts.Auth do
  alias Argon2
  alias Euler.Administration.Accounts.Admin
  alias Euler.Repo

  def authenticate(email, plain_text_password) do
    case Repo.get_by(Admin, email: email) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Argon2.verify_pass(plain_text_password, user.password_hash) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
