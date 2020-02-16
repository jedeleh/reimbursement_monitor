defmodule ReimbursementMonitor.Seeds.PayorProcedureMappings do 
  use Mix.Task
  
  alias ReimbursementMonitor.Schemas.Context
  
  def run() do 
    # for lazy idempotency. In a more perfect world, 
    # I'd do the check on each record
    if length(Context.list_payor_procedure_mappings()) == 0 do
      records()
      |> Enum.map(fn(mappings) -> 
        seed_mappings(mappings)
      end)
    end
  end

  defp seed_mappings(map) do 
    payor = Context.get_payor_by_name!(map.payor_name)
    map.procedures
    |> Enum.map(fn(procedure_map) -> 
      procedure = Context.get_procedure_by_name!(procedure_map.name)
      seed_payor_procedure_mappings(payor, procedure, procedure_map)
    end)
  end

  defp seed_payor_procedure_mappings(payor, procedure, procedure_map) do
    %{
      payor: payor,
      procedure: procedure,
      payor_procedure_name: procedure_map.payor_procedure_name,
      payor_procedure_id: procedure_map.payor_procedure_id
    }
    |> Context.create_payor_procedure_mapping()
  end
  
  defp records do 
    [
      %{
        payor_name: "Pumana",
        procedures: [
          %{
            name: "Hip Replacement",
            payor_procedure_id: "0e346ba3-2b0c-463d-a3d0-91a5d32a0ade",
            payor_procedure_name: "Hip Replacement"
          },
          %{
            name: "Liver Transplant",
            payor_procedure_id: "897d9271-370b-4a29-b4bb-1944cf0407af",
            payor_procedure_name: "Liver Transplant"
          },
          %{
            name: "Arm Amputation",
            payor_procedure_id: "f94ff092-acc1-46c2-86de-300fdeec9b83",
            payor_procedure_name: "Arm Amputation"
          },
          %{
            name: "Appendix Removal",
            payor_procedure_id: "2b392b45-7d20-42b2-a0ee-9ed5dac95cdc",
            payor_procedure_name: "Appendix Removal"
          },
          %{
            name: "Triple Bypass",
            payor_procedure_id: "9bf55346-fa25-45f1-a099-66ee41cf2188",
            payor_procedure_name: "Triple Bypass"
          }
        ]
      },
      %{
        payor_name: "DCDS",
        procedures: [
          %{
            name: "Hip Replacement",
            payor_procedure_id: "hip-replacement-r-side",
            payor_procedure_name: "Hip Replacement"
          },
          %{
            name: "Lobotomy",
            payor_procedure_id: "lobotomy",
            payor_procedure_name: "Lobotomy"
          },
          %{
            name: "Arm Amputation",
            payor_procedure_id: "amputation-upper-limb-r-side",
            payor_procedure_name: "Arm Amputation"
          },
          %{
            name: "Appendix Removal",
            payor_procedure_id: "appendicitis-recommendation",
            payor_procedure_name: "Appendix Removal"
          },
          %{
            name: "Triple Bypass",
            payor_procedure_id: "heart-surgery-bypass-x-3",
            payor_procedure_name: "Triple Bypass"
          }
        ]
      },
      %{
        payor_name: "Sigma",
        procedures: [
          %{
            name: "Hip Replacement",
            payor_procedure_id: "1009",
            payor_procedure_name: "Hip Replacement"
          },
          %{
            name: "Liver Transplant",
            payor_procedure_id: "6482",
            payor_procedure_name: "Liver Transplant"
          },
          %{
            name: "Lobotomy",
            payor_procedure_id: "1375",
            payor_procedure_name: "Lobotomy"
          },
          %{
            name: "Appendix Removal",
            payor_procedure_id: "5971",
            payor_procedure_name: "Appendix Removal"
          },
          %{
            name: "Triple Bypass",
            payor_procedure_id: "3246",
            payor_procedure_name: "Triple Bypass"
          }
        ]
      }
    ]
  end
end
ReimbursementMonitor.Seeds.PayorProcedureMappings.run()