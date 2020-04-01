defmodule Euler.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :ip, :string

      timestamps()
    end

    create unique_index(:users, :ip)
  end
end
