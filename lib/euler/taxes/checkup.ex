defmodule Euler.Taxes.Checkup do
  use Ecto.Schema
  import Ecto.Changeset

  alias Euler.Taxes.Checkup

  @required [:ip, :user_agent, :itn, :valid]

  schema "checkups" do
    field :ip, :string
    field :user_agent, :string
    field :itn, :string
    field :valid, :boolean

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(%Checkup{} = checkup, attrs) do
    checkup
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
