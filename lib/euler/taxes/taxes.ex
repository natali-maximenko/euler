defmodule Euler.Taxes do
  @moduledoc """
  Taxes context.
  """
  alias Euler.Taxes.{Itn, ItnChecker}

  def verify_itn(itn_str), do: ItnChecker.verify(itn_str)
  def change_itn, do: Itn.new()
end
