defmodule ReimbursementMonitor.Repo.Migrations.CreateProcedureTable do
  use Ecto.Migration

  def change do
    create table("procedures") do
      add :name, :string, size: 100, null: false
      add :polling_interval, :integer, default: 5

      timestamps()
    end
  end
end
