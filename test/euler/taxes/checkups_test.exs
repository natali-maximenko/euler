defmodule Euler.Taxes.TaxesTest do
  use Euler.DataCase

  alias Euler.Taxes
  alias Euler.Taxes.Checkup

  describe "checkups" do
    @valid_attrs %{ip: "some ip", itn: "some itn", user_agent: "some user_agent", valid: true}
    @update_attrs %{
      ip: "some updated ip",
      itn: "some updated itn",
      user_agent: "some updated user_agent",
      valid: false
    }
    @invalid_attrs %{ip: nil, itn: nil, user_agent: nil, valid: nil}

    def checkup_fixture(attrs \\ %{}) do
      {:ok, checkup} =
        attrs
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
      assert {:ok, %Checkup{} = checkup} = Taxes.create_checkup(@valid_attrs)
      assert checkup.ip == "some ip"
      assert checkup.itn == "some itn"
      assert checkup.user_agent == "some user_agent"
      assert checkup.valid == true
    end

    test "create_checkup/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taxes.create_checkup(@invalid_attrs)
    end

    test "update_checkup/2 with valid data updates the checkup" do
      checkup = checkup_fixture()
      assert {:ok, %Checkup{} = checkup} = Taxes.update_checkup(checkup, @update_attrs)
      assert checkup.ip == "some updated ip"
      assert checkup.itn == "some updated itn"
      assert checkup.user_agent == "some updated user_agent"
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
