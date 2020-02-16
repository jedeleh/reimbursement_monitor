defmodule ReimbursementMonitor.Repo do
  use Ecto.Repo,
    otp_app: :reimbursement_monitor,
    adapter: Ecto.Adapters.Postgres
end
