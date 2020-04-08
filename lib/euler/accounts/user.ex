defmodule Euler.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :ip, :string
    field :blocked_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:ip])
    |> validate_required([:ip])
    |> unique_constraint(:ip)
  end

  def block_changeset(user, attrs) do
    user
    |> cast(attrs, [:blocked_at])
  end
end
