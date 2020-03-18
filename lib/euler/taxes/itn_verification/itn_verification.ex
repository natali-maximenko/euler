defmodule Euler.Taxes.ItnVerification do
  alias Euler.Taxes.ItnVerification.{TenNumbersChecker, TwelveNumbersChecker}

  def verify(itn) when is_bitstring(itn) do
    case String.length(itn) do
      10 -> TenNumbersChecker.verify(itn)
      12 -> TwelveNumbersChecker.verify(itn)
      _ -> {:error, "not ITN"}
    end
  end

  def verify(_), do: {:error, "not string"}
end
