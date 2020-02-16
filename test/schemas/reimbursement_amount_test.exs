defmodule ReimbursementMonitor.Schemas.ReimbursementAmountTest do
  use ExUnit.Case
  doctest ReimbursementMonitor.Schemas.ReimbursementAmount

  alias ReimbursementMonitor.Schemas.ReimbursementAmount

  test "unhappy with a missing required parameter" do
    params = %{
      payor_id: 23,
      amount: 2.99
    }

    changeset = 
      %ReimbursementAmount{}
      |> ReimbursementAmount.changeset(params)

    refute changeset.valid?
  end

  test "valid if all required params are present" do 
    params = %{
      payor_id: 23,
      procedure_id: 46,
      amount: 2.99
    }

    changeset = 
      %ReimbursementAmount{}
      |> ReimbursementAmount.changeset(params)

    assert changeset.valid?
  end
end