defmodule Euler.Factories.Accounts.UserFactory do
  alias Faker.Internet

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Euler.Accounts.User{
          ip: Internet.ip_v4_address()
        }
      end
    end
  end
end
