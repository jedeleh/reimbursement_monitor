defmodule ReimbursementMonitor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      ReimbursementMonitor.Repo,
      ReimbursementMonitor.Polling.Scheduler,
      ReimbursementMonitor.Polling.JobAgent
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [
      strategy: :one_for_one, 
      name: ReimbursementMonitor.Supervisor
    ]
    process_info = Supervisor.start_link(children, opts)

    # and now, the magic...
    ReimbursementMonitor.kickoff_jobs()

    process_info
  end
end
