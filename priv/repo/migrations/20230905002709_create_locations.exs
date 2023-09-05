defmodule JustTravel.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :position, :geometry, null: false

      timestamps()
    end

    alter table(:tickets) do
      add :location_id, references(:locations, on_delete: :nothing, type: :binary_id)
    end
  end
end
