defmodule ReimbursementMonitor.Repo.Migrations.CreatePayorProceduresTable do
  use Ecto.Migration

  def change do
    create table("payor_procedure_mappings") do
      add :payor_id, references(:payors)
      add :procedure_id, references(:procedures)
      add :payor_procedure_name, :string
      add :payor_procedure_id, :string

      timestamps()
    end
  end
end
