defmodule Mpesa.MixProject do
  use Mix.Project

  def project do
    [
      app: :mpesa,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: "This is wrapper for Daraja Mpesa STK implementation(Lipa na Mpesa Online)",
      package: package(),
      deps: deps(),
      # Docs
      name: "Mpesa STK",
      source_url: "https://github.com/manuelgeek/mpesa_elixir.git",
      homepage_url: "https://github.com/manuelgeek/mpesa_elixir.git",
      docs: [
        # The main page in the docs
        main: "Mpesa STK",
        logo:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/M-PESA_LOGO-01.svg/1200px-M-PESA_LOGO-01.svg.png",
        extras: ["README.md"]
      ]
    ]
  end

  defp package do
    [
      maintainers: [" ManuEl Magak "],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/manuelgeek/mpesa_elixir.git"}
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
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.6"},
      {:timex, "~> 3.5"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
