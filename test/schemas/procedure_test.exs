defmodule ReimbursementMonitor.Schemas.ProcedureTest do
  use ExUnit.Case
  doctest ReimbursementMonitor.Schemas.Procedure

  alias ReimbursementMonitor.Schemas.Procedure

  test "unhappy with a missing required parameter" do
    params = %{
      polling_interval: 5000
    }

    changeset = 
      %Procedure{}
      |> Procedure.changeset(params)

    refute changeset.valid?
  end

  test "valid if all required params are present" do 
    params = %{
      name: "heart surgery",
      polling_interval: 5000
    }

    changeset = 
      %Procedure{}
      |> Procedure.changeset(params)

    assert changeset.valid?
  end
end