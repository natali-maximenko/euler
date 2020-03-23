defmodule Euler.Taxes do
  @moduledoc """
  Taxes context.
  """
  # TODO namespaces in modules
  alias Euler.Taxes.{CheckupQueries, ItnChecker}

  # Verification
  def verify_itn(itn_str), do: ItnChecker.verify(itn_str)

  # Checkups
  def build_checkup, do: CheckupQueries.change()
  def create_checkup(attrs), do: CheckupQueries.create(attrs)
  def list_checkups(ip), do: CheckupQueries.list(ip)
  def get_checkup(id), do: CheckupQueries.get(id)
end
