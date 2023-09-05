defmodule JustTravel.Repo.Migrations.AddDiscountAndChildPrice do
  use Ecto.Migration

  def change do
    alter table(:tickets) do
      add :discount, :decimal
      add :child_price, :decimal
    end
  end
end
