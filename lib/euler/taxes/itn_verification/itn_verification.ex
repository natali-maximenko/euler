defmodule Euler.Taxes.ItnVerification do
  alias Euler.Taxes.ItnVerification.{TenNumbersChecker, TwelveNumbersChecker}

  def verify(checksum) when is_integer(checksum) do
    int_len = checksum |> Integer.to_charlist() |> length()

    case int_len do
      10 -> TenNumbersChecker.verify(checksum)
      12 -> TwelveNumbersChecker.verify(checksum)
      _ -> {:error, "not ITN"}
    end
  end

  def verify(checksum) when is_integer(checksum) and checksum > 0, do: {:ok, false}
  def verify(_), do: {:error, "not integer"}
end
