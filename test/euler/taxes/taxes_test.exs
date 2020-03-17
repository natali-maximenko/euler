defmodule Euler.Taxes.TaxesTest do
  use Euler.DataCase

  alias Euler.Taxes

  describe "#verify_itn/1" do
    test "with valid checksum" do
      checksum = 732_897_853_530
      {:ok, result} = Taxes.verify_itn(checksum)
      assert result
    end

    test "with invalid checksum" do
      checksum = 732_897_853_531
      {:ok, result} = Taxes.verify_itn(checksum)
      assert result
    end

    test "with invalid itn returns error with message" do
      assert {:error, _message} = Taxes.verify_itn("1111")
    end
  end
end
