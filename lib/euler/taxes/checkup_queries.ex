defmodule Euler.Taxes.CheckupQueries do
  import Ecto.Query

  alias Euler.Repo
  alias Euler.Taxes.Checkup

  def create(attrs \\ %{}) do
    %Checkup{}
    |> Checkup.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Checkup{} = checkup, attrs) do
    checkup
    |> Checkup.changeset(attrs)
    |> Repo.update()
  end

  def change(%Checkup{} = checkup), do: Checkup.changeset(checkup, %{})
  def get(id), do: Repo.get(Checkup, id)

  def list(nil) do
    Repo.all(from ch in Checkup, order_by: [desc: :inserted_at])
  end

  def list(ip) do
    Repo.all(from ch in Checkup, where: ch.ip == ^ip, order_by: [desc: :inserted_at])
  end
end
