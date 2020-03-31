defmodule Euler.Taxes.TaxesTest do
  use Euler.DataCase

  alias Euler.Taxes
  alias Euler.Taxes.Checkup
  alias Euler.Accounts

  describe "checkups" do
    @valid_attrs %{itn: "some itn", valid: true}
    @update_attrs %{
      itn: "some updated itn",
      valid: false
    }
    @invalid_attrs %{ip: nil, itn: nil, user_agent: nil, valid: nil}

    def checkup_fixture(attrs \\ %{}) do
      {:ok, user} = Accounts.create_user(%{ip: "127.0.0.1"})

      {:ok, checkup} =
        attrs
        |> Map.put(:user_id, user.id)
        |> Enum.into(@valid_attrs)
        |> Taxes.create_checkup()

      checkup
    end

    test "list_checkups/0 returns all checkups" do
      checkup = checkup_fixture()
      assert Taxes.list_checkups() == [checkup]
    end

    test "get_checkup/1 returns the checkup with given id" do
      checkup = checkup_fixture()
      assert Taxes.get_checkup(checkup.id) == checkup
    end

    test "create_checkup/1 with valid data creates a checkup" do
      {:ok, user} = Accounts.create_user(%{ip: "127.0.0.1"})
      attrs = Map.put(@valid_attrs, :user_id, user.id)
      assert {:ok, %Checkup{} = checkup} = Taxes.create_checkup(attrs)
      assert checkup.itn == "some itn"
      assert checkup.valid == true
    end

    test "create_checkup/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taxes.create_checkup(@invalid_attrs)
    end

    test "update_checkup/2 with valid data updates the checkup" do
      checkup = checkup_fixture()
      assert {:ok, %Checkup{} = checkup} = Taxes.update_checkup(checkup, @update_attrs)
      assert checkup.itn == "some updated itn"
      assert checkup.valid == false
    end

    test "update_checkup/2 with invalid data returns error changeset" do
      checkup = checkup_fixture()
      assert {:error, %Ecto.Changeset{}} = Taxes.update_checkup(checkup, @invalid_attrs)
      assert checkup == Taxes.get_checkup(checkup.id)
    end

    test "change_checkup/1 returns a checkup changeset" do
      checkup = checkup_fixture()
      assert %Ecto.Changeset{} = Taxes.change_checkup(checkup)
    end
  end
end
