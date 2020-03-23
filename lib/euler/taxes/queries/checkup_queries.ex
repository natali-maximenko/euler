defmodule Euler.Taxes.CheckupQueries do
  import Ecto.Query

  alias Euler.Repo
  alias Euler.Taxes.Checkup

  def create(attrs) do
    %Checkup{}
    |> Checkup.changeset(attrs)
    |> Repo.insert()
  end

  def change, do: Checkup.changeset(%Checkup{}, %{})
  def get(id), do: Repo.get(Checkup, id)

  def list(ip) do
    Repo.all(from ch in Checkup, where: ch.ip == ^ip, order_by: [desc: :inserted_at])
  end
end
