defmodule CqrsAbsinthe.MixProject do
  use Mix.Project

  def project do
    [
      app: :cqrs_tools_absinthe,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/elixir-cqrs/cqrs_tools_absinthe",
      package: [
        description: "Absinthe macros for `cqrs_tools` commands and queries",
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/elixir-cqrs/cqrs_tools_absinthe"}
      ],
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:absinthe, "~> 1.7"},
      {:cqrs_tools, path: "../cqrs_tools"},
      #
      # test and dev deps
      {:etso, "~> 0.1.6", only: [:test]},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:elixir_uuid, "~> 1.6", override: true, hex: :uuid_utils, only: [:test]}
    ]
  end
end
