defmodule Euler.Taxes.Checkup do
  use Ecto.Schema
  import Ecto.Changeset

  alias Euler.Accounts.User
  alias Euler.Taxes.Checkup

  @required [:user_id, :itn, :valid]

  schema "checkups" do
    field :itn, :string
    field :valid, :boolean

    belongs_to :user, User

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(%Checkup{} = checkup, attrs) do
    checkup
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> foreign_key_constraint(:user_id)
  end
end
