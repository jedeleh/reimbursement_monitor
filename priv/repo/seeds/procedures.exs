defmodule ReimbursementMonitor.Seeds.Procedures do 
  use Mix.Task
  
  alias ReimbursementMonitor.Schemas.Context
  
  def run() do 
    IO.puts "RUNNING PROCEDURES"
    # for lazy idempotency. In a more perfect world, 
    # I'd do the check on each record
    if length(Context.list_procedures()) == 0 do
      [
        %{
          name: "Hip Replacement", 
          polling_interval: 5
        },
        %{
          name: "Liver Transplant", 
          polling_interval: 5
        },
        %{
          name: "Lobotomy", 
          polling_interval: 5
        },
        %{
          name: "Arm Amputation", 
          polling_interval: 5
        },
        %{
          name: "Appendix Removal", 
          polling_interval: 5
        },
        %{
          name: "Triple Bypass", 
          polling_interval: 5
        }
      ]
      |> Enum.map(fn(map) -> 
        create_procedure(map)
      end)
    end
  end

  defp create_procedure(map) do
    Context.create_procedure(map)
  end
end
ReimbursementMonitor.Seeds.Procedures.run()