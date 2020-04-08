defmodule EulerWeb.Administration.CheckupView do
  use EulerWeb, :view
  alias EulerWeb.Router.Helpers, as: Routes

  def time(timestamp \\ DateTime.utc_now()) do
    timestamp |> to_string() |> String.slice(0..-9)
  end

  def result_msg(true), do: "корректен"
  def result_msg(false), do: "некорректен"
end
