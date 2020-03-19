defmodule Euler.Taxes do
  @moduledoc """
  Taxes context.
  """
  alias Euler.Taxes.ItnChecker

  def verify_itn(itn_str), do: ItnChecker.verify(itn_str)
end
