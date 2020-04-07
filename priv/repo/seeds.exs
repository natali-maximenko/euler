# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Euler.Repo.insert!(%Euler.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Euler.Administration.Accounts
alias Euler.Repo

existed = Repo.get_by(Accounts.Admin, email: "admin@taxes.info")

if is_nil(existed) do
  {:ok, _admin} =
    Accounts.create_admin(%{
      email: "admin@taxes.info",
      role: :admin,
      password: "adminadmin",
      password_confirmation: "adminadmin"
    })
end

operator = Repo.get_by(Accounts.Admin, email: "operator@taxes.info")

if is_nil(operator) do
  {:ok, _operator} =
    Accounts.create_admin(%{
      email: "operator@taxes.info",
      role: :operator,
      password: "testtest",
      password_confirmation: "testtest"
    })
end
