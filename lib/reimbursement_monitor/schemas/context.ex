defmodule ReimbursementMonitor.Schemas.Context do
  @moduledoc """
  The shared context for the various models.
  """

  import Ecto.Query, warn: false
  alias ReimbursementMonitor.Repo

  alias ReimbursementMonitor.Schemas.{
    ReimbursementAmount,
    Procedure,
    Payor,
    PayorProcedureMapping
  }

  # NOTE -----------------------------------------------------
  # NOTE ReimbursementAmount context starts here
  # NOTE -----------------------------------------------------

  @doc """
  Returns the list of ReimbursementAmounts.

  ## Examples

      iex> list_reimbursement_amounts()
      [%ReimbursementAmount{}, ...]

  """
  def list_reimbursement_amounts do
    Repo.all(ReimbursementAmount)
  end

  @doc """
  Gets a single ReimbursementAmount.

  Raises `Ecto.NoResultsError` if the ReimbursementAmount does not exist.

  ## Examples

      iex> get_reimbursement_amount!(123)
      %ReimbursementAmount{}

      iex> get_reimbursement_amount!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reimbursement_amount!(id), do: Repo.get!(ReimbursementAmount, id)

  @doc """
  Creates a ReimbursementAmount.

  ## Examples

      iex> create_reimbursement_amount(%{field: value})
      {:ok, %ReimbursementAmount{}}

      iex> create_reimbursement_amount(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reimbursement_amount(attrs \\ %{}) do
    %ReimbursementAmount{}
    |> ReimbursementAmount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ReimbursementAmount.

  ## Examples

      iex> update_reimbursement_amount(reimbursement_amount, %{field: new_value})
      {:ok, %ReimbursementAmount{}}

      iex> update_reimbursement_amount(reimbursement_amount, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reimbursement_amount(%ReimbursementAmount{} = reimbursement_amount, attrs) do
    reimbursement_amount
    |> ReimbursementAmount.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ReimbursementAmount.

  ## Examples

      iex> delete_reimbursement_amount(reimbursement_amount)
      {:ok, %ReimbursementAmount{}}

      iex> delete_reimbursement_amount(reimbursement_amount)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reimbursement_amount(%ReimbursementAmount{} = reimbursement_amount) do
    Repo.delete(reimbursement_amount)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reimbursement_amount changes.

  ## Examples

      iex> change_reimbursement_amount(reimbursement_amount)
      %Ecto.Changeset{source: %ReimbursementAmount{}}

  """
  def change_reimbursement_amount(%ReimbursementAmount{} = reimbursement_amount) do
    ReimbursementAmount.changeset(reimbursement_amount, %{})
  end

  # NOTE ------------------------------------------------------
  # NOTE: Payor context starts here
  # NOTE ------------------------------------------------------

  @doc """
  Returns the list of Payor.

  ## Examples

      iex> list_payors()
      [%Payor{}, ...]

  """
  def list_payors do
    from(p in Payor, 
      preload: [:procedures]
    )
    |> Repo.all()
  end

  @doc """
  Gets a single Payor.

  Raises `Ecto.NoResultsError` if the Payor does not exist.

  ## Examples

      iex> get_payor!(123)
      %Payor{}

      iex> get_payor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_payor!(id), do: Repo.get!(Payor, id)

  @doc """
  Gets a single Payor by name

  Raises `Ecto.NoResultsError` if the Payor does not exist.

  ## Examples

      iex> get_payor_by_name!("abc")
      %Payor{}

      iex> get_payor_by_name!("gef")
      ** (Ecto.NoResultsError)

  """
  def get_payor_by_name!(name) do
    from(
      p in Payor, 
      where: p.name == ^name
    )
    |> Repo.one!()
  end

  @doc """
  Creates a Payor.

  ## Examples

      iex> create_payor(%{field: value})
      {:ok, %Payor{}}

      iex> create_payor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_payor(attrs \\ %{}) do
    %Payor{}
    |> Payor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a Payor.

  ## Examples

      iex> update_payor(payor, %{field: new_value})
      {:ok, %Payor{}}

      iex> update_payor(payor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_payor(%Payor{} = payor, attrs) do
    payor
    |> Payor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Payor.

  ## Examples

      iex> delete_payor(payor)
      {:ok, %Payor{}}

      iex> delete_payor(payor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_payor(%Payor{} = payor) do
    Repo.delete(payor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking payor changes.

  ## Examples

      iex> change_payor(payor)
      %Ecto.Changeset{source: %Payor{}}

  """
  def change_payor(%Payor{} = payor) do
    Payor.changeset(payor, %{})
  end

  # NOTE ------------------------------------------------------
  # NOTE: Procedure context starts here
  # NOTE ------------------------------------------------------

  @doc """
  Returns the list of Procedures.

  ## Examples

      iex> list_procedures()
      [%Procedure{}, ...]

  """
  def list_procedures do
    from(p in Procedure,
      preload: [:payors]
    )
    |> Repo.all()
  end

  @doc """
  Gets a single Procedure.

  Raises `Ecto.NoResultsError` if the Procedure does not exist.

  ## Examples

      iex> get_procedure!(123)
      %Procedure{}

      iex> get_procedure!(456)
      ** (Ecto.NoResultsError)

  """
  def get_procedure!(id), do: Repo.get!(Procedure, id)

  @doc """
  Gets a single Procedure by name

  Raises `Ecto.NoResultsError` if the Procedure does not exist.

  ## Examples

      iex> get_procedure_by_name!("abc")
      %Payor{}

      iex> get_procedure_by_name!("gef")
      ** (Ecto.NoResultsError)

  """
  def get_procedure_by_name!(name) do
    from(
      p in Procedure, 
      where: p.name == ^name
    )
    |> Repo.one!()
  end

  @doc """
  Creates a Procedure.

  ## Examples

      iex> create_procedure(%{field: value})
      {:ok, %Procedure{}}

      iex> create_procedure(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_procedure(attrs \\ %{}) do
    %Procedure{}
    |> Procedure.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a Procedure.

  ## Examples

      iex> update_procedure(procedure, %{field: new_value})
      {:ok, %Procedure{}}

      iex> update_procedure(procedure, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_procedure(%Procedure{} = procedure, attrs) do
    procedure
    |> Procedure.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Procedure.

  ## Examples

      iex> delete_procedure(procedure)
      {:ok, %Procedure{}}

      iex> delete_procedure(procedure)
      {:error, %Ecto.Changeset{}}

  """
  def delete_procedure(%Procedure{} = procedure) do
    Repo.delete(procedure)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking procedure changes.

  ## Examples

      iex> change_procedure(procedure)
      %Ecto.Changeset{source: %Procedure{}}

  """
  def change_procedure(%Procedure{} = procedure) do
    Procedure.changeset(procedure, %{})
  end

  # NOTE -----------------------------------------------------
  # NOTE PayorProcedureMapping context starts here
  # NOTE -----------------------------------------------------

  @doc """
  Returns the list of PayorProcedureMappings.

  ## Examples

      iex> list_payor_procedure_mappings()
      [%PayorProcedureMapping{}, ...]

  """
  def list_payor_procedure_mappings do
    Repo.all(PayorProcedureMapping)
  end

  @doc """
  Gets a single PayorProcedureMapping.

  Raises `Ecto.NoResultsError` if the PayorProcedureMapping does not exist.

  ## Examples

      iex> get_payor_procedure_mapping!(123)
      %PayorProcedureMapping{}

      iex> get_payor_procedure_mapping!(456)
      ** (Ecto.NoResultsError)

  """
  def get_payor_procedure_mapping!(id), do: Repo.get!(PayorProcedureMapping, id)

  @doc """
  Creates a PayorProcedureMapping.

  ## Examples

      iex> create_payor_procedure_mapping(%{field: value})
      {:ok, %PayorProcedureMapping{}}

      iex> create_payor_procedure_mapping(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_payor_procedure_mapping(attrs \\ %{}) do
    %PayorProcedureMapping{}
    |> PayorProcedureMapping.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a PayorProcedureMapping.

  ## Examples

      iex> update_payor_procedure_mapping(procedure, %{field: new_value})
      {:ok, %PayorProcedureMapping{}}

      iex> update_payor_procedure_mapping(payor_procedure_mappings, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_payor_procedure_mapping(%PayorProcedureMapping{} = procedure, attrs) do
    procedure
    |> PayorProcedureMapping.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PayorProcedureMapping.

  ## Examples

      iex> delete_payor_procedure_mapping(payor_procedure_mapping)
      {:ok, %PayorProcedureMapping{}}

      iex> delete_payor_procedure_mapping(payor_procedure_mapping)
      {:error, %Ecto.Changeset{}}

  """
  def delete_payor_procedure_mapping(%PayorProcedureMapping{} = payor_procedure_mapping) do
    Repo.delete(payor_procedure_mapping)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking payor procedure mapping changes.

  ## Examples

      iex> change_payor_procedure_mapping(procedure)
      %Ecto.Changeset{source: %PayorProcedureMapping{}}

  """
  def change_payor_procedure_mapping(%PayorProcedureMapping{} = payor_procedure_mapping) do
    PayorProcedureMapping.changeset(payor_procedure_mapping, %{})
  end

end
