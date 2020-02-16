defmodule ReimbursementMonitor.Schemas.PayorProcedureMapping do
  use Ecto.Schema
  import Ecto.Changeset

  alias ReimbursementMonitor.Schemas.{
    Procedure,
    Payor
  }

  @moduledoc """
  Representation of the different ways a payor specifies procedures. The
  payors have different keys they use for the id & name of a procedure.
  polling

  """

  schema "payor_procedure_mappings" do
    belongs_to :payor, Payor
    belongs_to :procedure, Procedure
    field :payor_procedure_name, :string
    field :payor_procedure_id, :string

    timestamps()
  end

  @doc """
  Changeset generation. 

  ## Examples

      iex> ReimbursementMonitor.Schemas.PayorProcedureMapping.changeset(
      ...>   %ReimbursementMonitor.Schemas.PayorProcedureMapping{}, 
      ...>   %{
      ...>     payor_id: 12,
      ...>     procedure_id: 24,  
      ...>     payor_procedure_name: "Full frontal lobotomy", 
      ...>     payor_procedure_id: "123-234-56"
      ...>   }
      ...> )
      #Ecto.Changeset<action: nil, changes: %{payor: nil, payor_procedure_id: \"123-234-56\", payor_procedure_name: \"Full frontal lobotomy\", procedure: nil}, errors: [], data: #ReimbursementMonitor.Schemas.PayorProcedureMapping<>, valid?: true>

  """
  def changeset(model, params \\ %{}) do 
    model
    |> cast(params, all_params())
    |> validate_required(required())
    |> put_assoc(:payor, params[:payor])
    |> put_assoc(:procedure, params[:procedure])
  end

  def all_params do 
    required() ++ optional()
  end

  def optional do 
    []
  end

  def required do
    [
      :payor_procedure_name,
      :payor_procedure_id
    ]
  end
end