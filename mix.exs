defmodule Mpesa.MixProject do
  use Mix.Project

  def project do
    [
      app: :mpesa,
      version: "0.1.1",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: "This is wrapper for Daraja Mpesa STK implementation(Lipa na Mpesa Online)",
      package: package(),
      deps: deps(),
      # Docs
      name: "Mpesa Elixir",
      source_url: "https://github.com/manuelgeek/mpesa_elixir.git",
      homepage_url: "https://hexdocs.pm/mpesa/Mpesa.html",
      docs: [
        # The main page in the docs
        main: "Mpesa",
        # logo:
        #   "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/M-PESA_LOGO-01.svg/1200px-M-PESA_LOGO-01.svg.png",
        extras: ["README.md"]
      ]
    ]
  end

  defp package do
    [
      maintainers: [" ManuEl Magak "],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/manuelgeek/mpesa_elixir.git",
        "Documentation" => "https://hexdocs.pm/mpesa/Mpesa.html",
        "README" => "https://hexdocs.pm/mpesa/readme.html"
      }
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
    ]
  end
end
