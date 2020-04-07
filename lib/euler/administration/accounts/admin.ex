defmodule Euler.Administration.Accounts.Admin do
  use Ecto.Schema
  import Ecto.Changeset

  alias Argon2

  schema "admin_users" do
    field :email, :string
    field :password_hash, :string
    field :role, RoleEnum

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @required [:email, :role, :password, :password_confirmation]

  @doc false
  def changeset(admin, attrs) do
    admin
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{
           valid?: true,
           changes: %{email: _, password: password, password_confirmation: _}
         } = changeset
       ) do
    put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
