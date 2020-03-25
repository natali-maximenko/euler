defmodule Euler.Taxes.ItnChecker do
  @moduledoc """
  Verify ITN with ten and twelve numbers.
  """
  @ctr_multi1 [2, 4, 10, 3, 5, 9, 4, 6, 8]
  @ctr_multi2 [7, 2, 4, 10, 3, 5, 9, 4, 6, 8]
  @ctr_multi3 [3, 7, 2, 4, 10, 3, 5, 9, 4, 6, 8]

  def verify(itn) when is_bitstring(itn) do
    case String.length(itn) do
      10 -> verify_ten(itn)
      12 -> verify_twelve(itn)
      _ -> {:error, "not ITN"}
    end
  end

  def verify(_), do: {:error, "not string"}

  defp verify_ten(itn) do
    init_checksum = control_number(itn, :last)
    first_check_val = itn |> sequence(9) |> step1(@ctr_multi1)
    res_checksum = first_check_val |> step2() |> step3()
    {:ok, res_checksum == init_checksum}
  end

  defp verify_twelve(itn) do
    init_checksum = control_number(itn, :index, 10)
    first_check_val = itn |> sequence(10) |> List.insert_at(-1, 0) |> step1(@ctr_multi2)
    control_number1 = first_check_val |> step2() |> step3()
    second_check(itn, init_checksum, control_number1)
  end

  defp second_check(_itn, init_checksum, control_number1) when init_checksum != control_number1,
    do: {:ok, false}

  defp second_check(itn, _init_checksum, _control_number1) do
    checksum = control_number(itn, :last)
    first_check_val = itn |> sequence(11) |> step1(@ctr_multi3)
    control_number2 = first_check_val |> step2() |> step3()
    {:ok, control_number2 == checksum}
  end

  defp control_number(itn, :last), do: itn |> String.last() |> String.to_integer()

  defp control_number(itn, :index, index),
    do: itn |> String.slice(index, 1) |> String.to_integer()

  defp sequence(itn, len) do
    itn
    |> String.slice(0, len)
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  defp step1(list, control_multi) do
    list
    |> Enum.zip(control_multi)
    |> Enum.map(fn {val, mult} -> val * mult end)
    |> Enum.sum()
  end

  defp step2(check_val) do
    rem(check_val, 11)
  end

  defp step3(10), do: 0
  defp step3(check_val), do: check_val
end
