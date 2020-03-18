defmodule Euler.Taxes.ItnVerification.TenNumbersChecker do
  @moduledoc """
  Verify ITN with ten numbers length.
  """
  @multi [2, 4, 10, 3, 5, 9, 4, 6, 8]

  def verify(itn) do
    init_checksum = itn |> String.last() |> String.to_integer()
    list = itn |> String.slice(0, 9) |> to_integer_list()

    first_check_val =
      list
      |> multiply_rates()
      |> Enum.sum()

    second_check_val = div(first_check_val, 11) * 11
    res_checksum = first_check_val - second_check_val

    {:ok, res_checksum == init_checksum}
  end

  defp to_integer_list(str) do
    str
    |> String.graphemes()
    |> Enum.map(&String.to_integer(&1))
  end

  defp multiply_rates(list) do
    list
    |> Enum.zip(@multi)
    |> Enum.map(fn {item, mult} -> item * mult end)
  end
end
