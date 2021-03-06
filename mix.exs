defmodule TicketDispenser.Mixfile do
  use Mix.Project

  def project do
    [app: :ticket_dispenser,
     version: "0.0.1",
     test_pattern: "*_{test,eqc}.exs",
     elixir: "~> 1.0",
     deps: deps(Mix.env) ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  defp deps(:test), do: [{:eqc_ex, "~> 1.2.1"}]
  defp deps(_), do: []
  
end
