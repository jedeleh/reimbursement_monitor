defmodule ReimbursementMonitor.Polling.Worker do 
  
  alias ReimbursementMonitor.Schemas.Context
  alias ReimbursementMonitor.Polling.Client
  alias ReimbursementMonitor.Polling.JobAgent

  def process_procedure(procedure) do 
    procedure.payors
    |> Enum.map(fn(payor) -> 
      procedure_id = payor.
        payor_procedure_mapping.
        payor_procedure_id
      Client.get(payor.polling_url, procedure_id)
      |> process_data()
      |> update_job_cron_string(payor,procedure)
    end)

    {:ok, procedure, 6000}
  end

  defp update_job_cron_string(nil, _payor, _procedure), do: nil

  defp update_job_cron_string(reimbursement_amount, payor, procedure) do
    # find the job by procedure name
    # job = Agent.get(JobAgent, procedure.name)

    # update the Quantum.Job
  end

  defp process_data(json) do 
    reimbursement_amount = nil
    # TODO:
    # Here we've got to process the return values from the client api call.
    # This code will need to be generalized so it works with each
    # payor/procedure pairing pulls the right data out. Use
    # PayorProcedureMapping to find the id used
    reimbursement_amount
  end
end