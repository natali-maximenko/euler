defmodule Euler.AccountsTest do
  use Euler.DataCase

  alias Euler.Accounts

  describe "users" do
    alias Euler.Accounts.User

    @valid_attrs %{ip: "154.127.122.73"}
    @update_attrs %{ip: "111.115.106.129"}
    @invalid_attrs %{ip: nil}

    test "list_users/0 returns all users" do
      user = insert(:user)
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user)
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.ip == "154.127.122.73"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = insert(:user)
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.ip == "111.115.106.129"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert(:user)
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = build(:user)
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end

    test "block_user/1" do
      user = insert(:user)
      assert {:ok, %User{} = user} = Accounts.block_user(user)
      updated_user = Accounts.get_user!(user.id)
      assert updated_user.blocked_at
    end

    test "unblock_user/1" do
      user = insert(:user)
      assert {:ok, %User{} = block_user} = Accounts.block_user(user)
      assert block_user.blocked_at
      assert {:ok, %User{} = updated_user} = Accounts.unblock_user(block_user)
      refute updated_user.blocked_at
    end
  end
end
