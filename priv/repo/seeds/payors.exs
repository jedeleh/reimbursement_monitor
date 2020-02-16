defmodule ReimbursementMonitor.Seeds.Payors do 
  use Mix.Task
  
  alias ReimbursementMonitor.Schemas.Context
  
  def run() do 
    # for lazy idempotency. In a more perfect world, I'd do the check on each
    # record
    if length(Context.list_payors()) == 0 do
      # punama
      %{
        name: "Pumana", 
        polling_url: "https://pumana.com/api/procedure/"
      }
      |> Context.create_payor()

      # dcds
      %{
        name: "DCDS", 
        polling_url: "https://api.dcds.com/procedure/"
      }
      |> Context.create_payor()

      %{
        name: "Sigma", 
        polling_url: "https://sigma.com/procedure/"
      }
      |> Context.create_payor()
    end
  end
end
ReimbursementMonitor.Seeds.Payors.run()