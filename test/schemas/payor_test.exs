defmodule ReimbursementMonitor.Schemas.PayorTest do
  use ExUnit.Case
  doctest ReimbursementMonitor.Schemas.Payor

  alias ReimbursementMonitor.Schemas.Payor

  test "unhappy with a missing required parameter" do
    params = %{
      polling_url: "www.burp.com"
    }

    changeset = 
      %Payor{}
      |> Payor.changeset(params)

    refute changeset.valid?
  end

  test "valid if all required params are present" do 
    params = %{
      name: "DCDS",
      polling_url: "www.burp.com"
    }

    changeset = 
      %Payor{}
      |> Payor.changeset(params)

    assert changeset.valid?
  end
end