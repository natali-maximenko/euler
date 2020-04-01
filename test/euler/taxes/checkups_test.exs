defmodule Euler.Taxes.TaxesTest do
  use Euler.DataCase

  alias Euler.Taxes
  alias Euler.Taxes.Checkup
  alias Euler.Accounts

  describe "checkups" do
    @valid_attrs %{itn: "5610077532", valid: true}
    @update_attrs %{
      itn: "5610077531",
      valid: false
    }
    @invalid_attrs %{itn: nil, valid: nil}

    test "list_checkups/0 returns all checkups" do
      checkup = insert(:checkup)
      assert Taxes.list_checkups() == [checkup]
    end

    test "get_checkup/1 returns the checkup with given id" do
      checkup = insert(:checkup)
      assert Taxes.get_checkup(checkup.id) == checkup
    end

    test "create_checkup/1 with valid data creates a checkup" do
      user = insert(:user)
      attrs = Map.put(@valid_attrs, :user_id, user.id)
      assert {:ok, %Checkup{} = checkup} = Taxes.create_checkup(attrs)
      assert checkup.itn == "5610077532"
      assert checkup.valid == true
    end

    test "create_checkup/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taxes.create_checkup(@invalid_attrs)
    end

    test "update_checkup/2 with valid data updates the checkup" do
      checkup = insert(:checkup)
      assert {:ok, %Checkup{} = checkup} = Taxes.update_checkup(checkup, @update_attrs)
      assert checkup.itn == "5610077531"
      assert checkup.valid == false
    end

    test "update_checkup/2 with invalid data returns error changeset" do
      checkup = insert(:checkup)
      assert {:error, %Ecto.Changeset{}} = Taxes.update_checkup(checkup, @invalid_attrs)
      assert checkup == Taxes.get_checkup(checkup.id)
    end

    test "change_checkup/1 returns a checkup changeset" do
      checkup = build(:checkup)
      assert %Ecto.Changeset{} = Taxes.change_checkup(checkup)
    end
  end
end
