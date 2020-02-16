defmodule ReimbursementMonitor.Repo.Migrations.CreatePayorsTable do
  use Ecto.Migration

  def change do
    create table("payors") do
      add :name, :string, size: 100, null: false
      add :polling_url, :string, size: 200

      timestamps()
    end
  end
end
