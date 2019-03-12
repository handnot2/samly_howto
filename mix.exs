defmodule SamlyHowto.Mixfile do
  use Mix.Project

  def project do
    [
      app: :samly_howto,
      version: "1.0.0",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {SamlyHowto.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  #
  # Phoenix 1.4 dependencies:
  #
  # {:phoenix, "~> 1.4"},
  # {:plug_cowboy, "~> 2.0"},
  #
  # Phoenix 1.3 dependencies:
  #
  # {:phoenix, "~> 1.3"},
  # {:plug_cowboy, "~> 1.0"},
  # {:esaml, "~> 3.7", override: true},
  #
  defp deps do
    [
      {:phoenix, "~> 1.4"},
      {:plug_cowboy, "~> 2.0"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:jason, "~> 1.1"},
      {:gettext, "~> 0.11"},
      {:samly, "~> 1.0.0"}
    ]
  end
end
