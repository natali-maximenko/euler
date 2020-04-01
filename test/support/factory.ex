defmodule Euler.Factory do
  use ExMachina.Ecto, repo: Euler.Repo

  use Euler.Factories.Accounts.UserFactory
  use Euler.Taxes.CheckupFactory
end
