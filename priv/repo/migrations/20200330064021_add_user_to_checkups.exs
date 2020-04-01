defmodule Euler.Repo.Migrations.AddUserToCheckups do
  use Ecto.Migration

  def up do
    alter table(:checkups) do
      remove :user_agent
      remove :ip
      add :user_id, references(:users), null: false
    end

    create index(:checkups, [:user_id])
  end

  def down do
    drop index(:checkups, [:user_id])

    alter table(:checkups) do
      add :user_agent, :string
      add :ip, :string
      remove :user_id
    end
  end
end
