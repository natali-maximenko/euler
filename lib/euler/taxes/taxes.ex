defmodule Euler.Taxes do
  @moduledoc """
  Taxes context.
  """
  alias Euler.Taxes.ItnVerification

  def verify_itn(checksum), do: ItnVerification.verify(checksum)
end
