defmodule Euler.Taxes.CheckupFactory do
  alias Faker.Util

  defmacro __using__(_opts) do
    quote do
      def checkup_factory do
        %Euler.Taxes.Checkup{
          itn: "561007753#{Util.digit()}",
          valid: nil,
          user: build(:user)
        }
      end
    end
  end
end
