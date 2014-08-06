defmodule ExProf.Mixfile do
  use Mix.Project

  def project do
    [ app: :exprof,
      version: "0.1.3",
      elixir: "~> 0.14.0 or ~> 0.15.0",
      deps: deps,
      description: description,
      package: package
    ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [ {:exprintf, "~> 0.1"} ]
  end

  defp description do
    """
    A simple code profiler for Elixir using eprof.
    """
  end

  defp package do
    [ contributors: ["parroty"],
      licenses: ["MIT"],
      links: [ { "GitHub", "https://github.com/parroty/exprof" } ] ]
  end
end
