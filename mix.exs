defmodule KyoboGoldenTime.MixProject do
  use Mix.Project

  def project do
    [
      app: :kyobo_golden_time,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:crawly, "~> 0.15.0"},
      {:floki, "~> 0.33.0"}
    ]
  end
end
