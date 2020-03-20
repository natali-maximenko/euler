defmodule Euler.Taxes.Itn do
  import Ecto.Changeset

  @schema %{itn: :string}

  def new do
    {%{}, @schema}
    |> cast(%{value: nil}, Map.keys(@schema))
  end

  @doc false
  def changeset(itn \\ %{}, attrs) do
    {itn, @schema}
    |> cast(attrs, Map.keys(@schema))
    |> validate_required(Map.keys(@schema))
  end
end
