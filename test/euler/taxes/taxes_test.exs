defmodule Euler.Taxes.TaxesTest do
  use Euler.DataCase

  alias Euler.Taxes

  describe "#verify_itn/1 with ten numbers" do
    test "with valid checksum" do
      checksum = "2366010808"
      {:ok, result} = Taxes.verify_itn(checksum)
      assert result
    end

    test "with valid checksum and zero end" do
      checksum = "6165186020"
      {:ok, result} = Taxes.verify_itn(checksum)
      assert result
    end

    test "with invalid checksum" do
      checksum = "2366010809"
      {:ok, result} = Taxes.verify_itn(checksum)
      refute result
    end

    test "with integer returns error with message" do
      assert {:error, "not string"} = Taxes.verify_itn(1)
    end

    test "with some string returns error with message" do
      assert {:error, "not ITN"} = Taxes.verify_itn("skljf")
    end
  end

  describe "#verify_itn/1 with twelve numbers" do
    test "with valid checksum" do
      checksum = "616508634138"
      {:ok, result} = Taxes.verify_itn(checksum)
      assert result
    end

    test "with invalid first control number" do
      checksum = "616508634148"
      {:ok, result} = Taxes.verify_itn(checksum)
      refute result
    end

    test "ends with zero and valid checksum" do
      checksum = "732897853530"
      {:ok, result} = Taxes.verify_itn(checksum)
      assert result
    end

    test "with invalid checksum" do
      checksum = "732897853531"
      {:ok, result} = Taxes.verify_itn(checksum)
      refute result
    end

    test "with invalid itn returns error with message" do
      assert {:error, _message} = Taxes.verify_itn(-1)
    end
  end
end
