defmodule ExProf.Mixfile do
  use Mix.Project

  def project do
    [ app: :exprof,
      version: "0.2.4",
      elixir: "~> 1.0",
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      extra_applications: [:tools]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      {:exprintf, "~> 0.2"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description do
    """
    A simple code profiler for Elixir using eprof.
    """
  end

  defp package do
    [ maintainers: ["parroty"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/parroty/exprof"} ]
  end
end
