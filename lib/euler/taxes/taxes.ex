defmodule Euler.Taxes do
  @moduledoc """
  Taxes context.
  """
  # TODO namespaces in modules
  alias Euler.Taxes.{CheckupQueries, Itn, ItnChecker}

  # Verification
  def verify_itn(itn_str), do: ItnChecker.verify(itn_str)
  def change_itn, do: Itn.new()

  # Checkups
  def build_checkup, do: CheckupQueries.change()
  def create_checkup(attrs), do: CheckupQueries.create(attrs)
  def list_checkups, do: CheckupQueries.list()
  def get_checkup(id), do: CheckupQueries.get(id)
end
