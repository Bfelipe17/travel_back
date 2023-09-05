defmodule JustTravel.Repo.Migrations.CreateCartAndCartItems do
  use Ecto.Migration

  def change do
    create table(:carts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      timestamps()
    end

    create table(:cart_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer
      add :cart_id, references(:carts, on_delete: :delete_all, type: :binary_id)
      add :ticket_id, references(:tickets, on_delete: :delete_all, type: :binary_id)
      timestamps()
    end
  end
end
