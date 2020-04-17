defmodule EulerWeb.TaxesView do
  use EulerWeb, :view

  def render("checkup.json", %{itn: itn, result: result}) do
    msg = result_msg(result)
    %{body: "[#{time()}] #{itn} : #{msg}"}
  end

  def render("error.json", %{msg: msg}) do
    %{body: "[error] #{msg}"}
  end

  def time(timestamp \\ DateTime.utc_now()) do
    timestamp |> to_string() |> String.slice(0..-9)
  end

  def result_msg(true), do: "корректен"
  def result_msg(false), do: "некорректен"
end
