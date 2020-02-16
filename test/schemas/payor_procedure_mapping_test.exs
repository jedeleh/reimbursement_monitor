defmodule ReimbursementMonitor.Schemas.PayorProcedureMappingTest do
  use ExUnit.Case
  doctest ReimbursementMonitor.Schemas.PayorProcedureMapping

  alias ReimbursementMonitor.Schemas.{
    PayorProcedureMapping,
    Payor, 
    Procedure,
    Context
  }
  alias ReimbursementMonitor.Test.Support.Factory
  alias ReimbursementMonitor.Repo

  setup do 
    payor = Factory.create_payor()
    procedure = Factory.create_procedure()
    %{
      procedure: procedure,
      payor: payor
    }
  end

  test "unhappy with a missing required parameter" do
    params = %{
      payor_procedure_id: "2342"
    }

    changeset = 
      %PayorProcedureMapping{}
      |> PayorProcedureMapping.changeset(params)

    refute changeset.valid?
  end

  test "valid if all required params are present", %{procedure: procedure, payor: payor} do 
    params = %{
      payor: payor,
      procedure: procedure,
      payor_procedure_name: "That one thing we do to patients",
      payor_procedure_id: "2342"
    }

    changeset = 
      %PayorProcedureMapping{}
      |> PayorProcedureMapping.changeset(params)

    assert changeset.valid?
  end

  test "associates payor & procedure", %{procedure: procedure, payor: payor} do 
    params = %{
      payor: payor,
      procedure: procedure,
      payor_procedure_name: "That one thing we do to patients",
      payor_procedure_id: "2342"
    }

    {:ok, new_item} = 
        %PayorProcedureMapping{}
        |> PayorProcedureMapping.changeset(params)
        |> Repo.insert()

    item = Context.get_payor_procedure_mapping!(new_item.id)
    |> Repo.preload([:payor, :procedure])
    assert item != nil
    assert item.payor == payor
    assert item.procedure == procedure
  end
end