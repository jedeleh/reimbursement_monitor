defmodule ReimbursementMonitor.Seeds.ReimbursementAmounts do 
  use Mix.Task
  
  alias ReimbursementMonitor.Schemas.Context
  
  def run(_), do: run()

  def run() do 
    # for lazy idempotency. In a more perfect world, I'd do the check on each
    # record
    if length(Context.list_reimbursement_amounts()) == 0 do
      pumana()
      # dcds()
      # sigma()
    end
  end

  defp pumana do 
    payor = Context.get_payor_by_name!("Pumana")
    [
      %{
        procedure_name: "Hip Replacement", 
        amount: 39.99
      },
      %{
        procedure_name: "Liver Transplant", 
        amount: 452.65
      },
      %{
        procedure_name: "Arm Amputation", 
        amount: 1.57
      },
      %{
        procedure_name: "Appendix Removal", 
        amount: 26.98
      },
      %{
        procedure_name: "Triple Bypass", 
        amount: 111.68
      }
    ]
    |> Enum.map(fn(map) -> 
      procedure = Context.get_procedure_by_name!(map.procedure_name)
      Context.create_reimbursement_amount(
        %{
          payor: payor,
          procedure: procedure,
          amount: map.amount
        }
      )
    end)
  end

  defp dcds do 
    payor = Context.get_payor_by_name!("DCDS")
    [
      %{
        procedure_name: "Hip Replacement", 
        amount: 41.99
      },
      %{
        procedure_name: "Lobotomy", 
        amount: 0.56
      },
      %{
        procedure_name: "Arm Amputation", 
        amount: 3.78
      },
      %{
        procedure_name: "Appendix Removal", 
        amount: 26.98
      },
      %{
        procedure_name: "Triple Bypass", 
        amount: 105.69
      }
    ]
    |> Enum.map(fn(map) -> 
      procedure = Context.get_procedure_by_name!(map.procedure_name)
      Context.create_reimbursement_amount(
        %{
          payor: payor,
          procedure: procedure,
          amount: map.amount
        }
      )
    end)
  end

  defp sigma do 
    payor = Context.get_payor_by_name!("Sigma")
    [
      %{
        procedure_name: "Hip Replacement", 
        amount: 40.19
      },
      %{
        procedure_name: "Liver Transplant", 
        amount: 443.21
      },
      %{
        procedure_name: "Lobotomy", 
        amount: 1.06
      },
      %{
        procedure_name: "Appendix Removal", 
        amount: 29.87
      },
      %{
        procedure_name: "Triple Bypass", 
        amount: 132.54
      }
    ]
    |> Enum.map(fn(map) -> 
      procedure = Context.get_procedure_by_name!(map.procedure_name)
      Context.create_reimbursement_amount(
        %{
          payor: payor,
          procedure: procedure,
          amount: map.amount
        }
      )
    end)
  end
end

ReimbursementMonitor.Seeds.ReimbursementAmounts.run()