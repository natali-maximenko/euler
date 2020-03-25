defmodule Euler.Taxes do
  @moduledoc """
  The Taxes context.
  """

  alias Euler.Taxes.{Checkup, CheckupQueries, ItnChecker}

  # Verification
  def verify_itn(itn_str), do: ItnChecker.verify(itn_str)

  # Checkups
  def change_checkup(checkup \\ %Checkup{}), do: CheckupQueries.change(checkup)
  def create_checkup(attrs), do: CheckupQueries.create(attrs)
  def update_checkup(checkup, attrs), do: CheckupQueries.update(checkup, attrs)
  def list_checkups(ip \\ nil), do: CheckupQueries.list(ip)
  def get_checkup(id), do: CheckupQueries.get(id)
end
