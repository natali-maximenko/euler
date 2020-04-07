defmodule Euler.Repo.Migrations.AddRoleToAdminUsers do
  use Ecto.Migration

  def up do
    RoleEnum.create_type()

    alter table(:admin_users) do
      add :role, RoleEnum.type()
    end
  end

  def down do
    alter table(:admin_users) do
      remove :role
    end

    RoleEnum.drop_type()
  end
end
