defmodule Euler.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :ip, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:ip])
    |> validate_required([:ip])
    |> unique_constraint(:ip)
  end
end
