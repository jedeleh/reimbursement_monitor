use Mix.Config

config :reimbursement_monitor, ReimbursementMonitor.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "reimbursement_monitor_db_test",
  hostname: "localhost",
  pool_size: 10
