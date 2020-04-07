defmodule Euler.Administration.AccountsTest do
  use Euler.DataCase

  alias Euler.Administration.Accounts

  describe "admin_users" do
    alias Euler.Administration.Accounts.Admin

    @valid_attrs %{
      email: "some@email.com",
      password: "some password",
      password_confirmation: "some password"
    }
    @update_attrs %{
      email: "some_updated@email.com",
      password: "some updated password",
      password_confirmation: "some updated password"
    }
    @invalid_attrs %{email: nil, password: nil}

    def admin_fixture(attrs \\ %{}) do
      {:ok, admin} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_admin()

      admin
    end

    test "list_admin_users/0 returns all admin_users" do
      admin = admin_fixture()
      assert Accounts.list_admin_users() == [admin]
    end

    test "get_admin!/1 returns the admin with given id" do
      admin = admin_fixture()
      assert Accounts.get_admin!(admin.id) == admin
    end

    test "create_admin/1 with valid data creates a admin" do
      assert {:ok, %Admin{} = admin} = Accounts.create_admin(@valid_attrs)
      assert {:ok, admin} == Argon2.check_pass(admin, "some password", hash_key: :password)
      assert admin.email == "some@email.com"
    end

    test "create_admin/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_admin(@invalid_attrs)
    end

    test "update_admin/2 with valid data updates the admin" do
      admin = admin_fixture()
      assert {:ok, %Admin{} = admin} = Accounts.update_admin(admin, @update_attrs)

      assert {:ok, admin} ==
               Argon2.check_pass(admin, "some updated password", hash_key: :password)

      assert admin.email == "some_updated@email.com"
    end

    test "update_admin/2 with invalid data returns error changeset" do
      admin = admin_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_admin(admin, @invalid_attrs)
      assert admin == Accounts.get_admin!(admin.id)
    end

    test "delete_admin/1 deletes the admin" do
      admin = admin_fixture()
      assert {:ok, %Admin{}} = Accounts.delete_admin(admin)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_admin!(admin.id) end
    end

    test "change_admin/1 returns a admin changeset" do
      admin = admin_fixture()
      assert %Ecto.Changeset{} = Accounts.change_admin(admin)
    end
  end
end
