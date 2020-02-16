defmodule ReimbursementMonitor.Repo.Migrations.CreateReimbursementAmounts do
  use Ecto.Migration

  def change do
    create table("reimbursement_amounts") do
      add :payor_id, references(:payors)
      add :procedure_id, references(:procedures)
      add :amount, :float, null: false

      timestamps()
    end
  end
end
