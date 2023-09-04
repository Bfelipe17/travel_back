defmodule JustTravel.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :string
      add :date, :date
      add :price, :decimal

      timestamps()
    end

    alter table(:reviews) do
      add :ticket_id, references(:tickets, on_delete: :delete_all, type: :binary_id)
    end
  end
end
