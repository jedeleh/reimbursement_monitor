defmodule ReimbursementMonitor.Schemas.ReimbursementAmount do
  use Ecto.Schema
  import Ecto.Changeset

  alias ReimbursementMonitor.Schemas.{
    Procedure,
    Payor
  }

  @moduledoc """
  Representation of the current amount a given vendor is reimbursing for a
  given procedure.
  """
  schema "reimbursement_amounts" do
    belongs_to :payor, Payor
    belongs_to :procedure, Procedure
    field :amount, :float

    timestamps()
  end

  @doc """
  Changeset generation. 

  ## Examples

      iex> ReimbursementMonitor.Schemas.ReimbursementAmount.changeset(
      ...>   %ReimbursementMonitor.Schemas.ReimbursementAmount{}, 
      ...>   %{
      ...>     procedure_id: 1, 
      ...>     payor_id: 2,
      ...>     amount: 1.99
      ...>   }
      ...> )
      #Ecto.Changeset<action: nil, changes: %{amount: 1.99, payor_id: 2, procedure_id: 1}, errors: [], data: #ReimbursementMonitor.Schemas.ReimbursementAmount<>, valid?: true>

  """
  def changeset(reimbursement_amount, params \\ %{}) do 
    reimbursement_amount
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
    [:amount]
  end
end