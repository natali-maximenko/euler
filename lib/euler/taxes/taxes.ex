defmodule Euler.Taxes do
  @moduledoc """
  Taxes context.
  """

  def verify_itn(checksum) when is_integer(checksum) and checksum > 0, do: {:ok, true}
  def verify_itn(checksum) when is_integer(checksum) and checksum < 0, do: {:ok, false}
  def verify_itn(_), do: {:error, "not integer"}
end
