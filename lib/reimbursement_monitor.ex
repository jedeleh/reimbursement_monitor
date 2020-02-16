defmodule ReimbursementMonitor do
  import Crontab.CronExpression

  alias ReimbursementMonitor.Schemas.Context
  alias ReimbursementMonitor.Polling.{
    Worker,
    JobAgent,
    Scheduler
  }


  def kickoff_jobs do 
    Context.list_procedures()
    |> Enum.map(fn(procedure) -> 
      start_job(procedure)
      |> JobAgent.put(procedure.name)
    end)
  end

  defp start_job(procedure) do 
    Scheduler.new_job()
    |> Quantum.Job.set_name(String.to_atom(procedure.name))
    |> Quantum.Job.set_schedule(~e[#{procedure.polling_interval} * * * * *])
    |> Quantum.Job.set_task(fn -> 
      Worker.process_procedure(procedure)
    end)
    |> ReimbursementMonitor.Polling.Scheduler.add_job()
  end
end
