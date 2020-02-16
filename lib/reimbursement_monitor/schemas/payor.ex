defmodule ReimbursementMonitor.Schemas.Payor do
  use Ecto.Schema
  import Ecto.Changeset

  alias ReimbursementMonitor.Schemas.{
    Procedure,
    PayorProcedureMapping
  }

  @moduledoc """
  Representation of an insurance provider. Includes the URL that we will be
  polling

  """

  schema "payors" do
    field :name, :string, null: :false
    field :polling_url, :string, null: :false

    many_to_many :procedures, 
      Procedure, 
      join_through: "payor_procedure_mappings"

    timestamps()
  end

  @doc """
  Changeset generation. 

  ## Examples

      iex> ReimbursementMonitor.Schemas.Payor.changeset(
      ...>   %ReimbursementMonitor.Schemas.Payor{}, 
      ...>   %{
      ...>     name: "HealthcareYay Co", 
      ...>     polling_url: "www.careyay.co"
      ...>   }
      ...> )
      #Ecto.Changeset<action: nil, changes: %{name: "HealthcareYay Co", polling_url: "www.careyay.co"}, errors: [], data: #ReimbursementMonitor.Schemas.Payor<>, valid?: true>

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
    [:name, :polling_url]
  end
end