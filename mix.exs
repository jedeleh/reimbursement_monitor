defmodule ReimbursementMonitor.MixProject do
  use Mix.Project

  def project do
    [
      app: :reimbursement_monitor,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :dev,
      elixirc_paths: [
        "lib",
        "test/support"
      ],
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ReimbursementMonitor.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:quantum, "~> 2.3"},
      {:timex, "~> 3.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": [
        "ecto.create", 
        "ecto.migrate", 
        "ecto.seeds"
        ],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.seeds": [
        "run priv/repo/seeds/payors.exs",
        "run priv/repo/seeds/procedures.exs",
        "run priv/repo/seeds/payor_procedure_mappings.exs",
        "run priv/repo/seeds/reimbursement_amounts.exs"
      ],
      "ecto.test.reset": &test_reset/1
    ]
  end

  defp test_reset(_) do
    Mix.env(:test) # or whatever env you need
    Mix.Task.run("ecto.drop")
    Mix.Task.run("ecto.create")
    Mix.Task.run("ecto.migrate")
  end
end
