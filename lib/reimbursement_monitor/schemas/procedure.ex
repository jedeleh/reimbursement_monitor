defmodule ReimbursementMonitor.Schemas.Procedure do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
  Representation of a single procedure. Includes a polling interval numberres
  representing the number of seconds between polling attempts for that
  procedure.

  This could have been represented as hardcoded data, but I'm assuming that
  there aren't many insurance providers with only these procedures. New ones
  can be added, along with a PayorProcedureMapping record

  requirement: The reimbursement amount poll rate is configurable per procedure
  """

  alias ReimbursementMonitor.Schemas.Payor

  schema "procedures" do
    field :name, :string, null: :false
    field :polling_interval, :integer, default: 10000

    many_to_many :payors, 
      Payor, 
      join_through: "payor_procedure_mappings"

    timestamps()
  end

  @doc """
  Changeset generation. 

  ## Examples

      iex> ReimbursementMonitor.Schemas.Procedure.changeset(
      ...>   %ReimbursementMonitor.Schemas.Procedure{}, 
      ...>   %{
      ...>     name: "Hip Replacement", 
      ...>     polling_interval: 5000
      ...>   }
      ...> )
      #Ecto.Changeset<action: nil, changes: %{name: "Hip Replacement", polling_interval: 5000}, errors: [], data: #ReimbursementMonitor.Schemas.Procedure<>, valid?: true>

  """
  def changeset(model, params \\ %{}) do 
    model
    |> cast(params, all_params())
    |> validate_required(required())
  end

  def all_params do 
    required() ++ optional()
  end

  def optional do 
    []
  end

  def required do
    [:name, :polling_interval]
  end
end