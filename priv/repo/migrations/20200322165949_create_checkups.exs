defmodule Euler.Repo.Migrations.CreateCheckups do
  use Ecto.Migration

  def change do
    create table("checkups") do
      add :ip, :string
      add :user_agent, :string
      add :itn, :string
      add :valid, :boolean
      timestamps(type: :utc_datetime_usec)
    end
  end
end
