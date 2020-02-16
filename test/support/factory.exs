defmodule ReimbursementMonitor.Test.Support.Factory do 
  
  alias ReimbursementMonitor.Schemas.Context

  def create_procedure do 
    {:ok, procedure} =
      Context.create_procedure(
        %{
          name: "NeatO insurance",
          polling_interval: 10
        }
      )

    procedure
  end

  def create_payor(name \\ "test_name", polling_url \\ "www.example.com") do 
    {:ok, payor} = 
      Context.create_payor(
        %{
          name: name,
          polling_url: polling_url
        }
      )
    payor
  end
end