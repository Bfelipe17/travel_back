defmodule JustTravel.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :score, :float, null: false
      add :comment, :string

      timestamps()
    end
  end
end
