defmodule JustTravel.Repo.Migrations.AddImageToTicket do
  use Ecto.Migration

  def change do
    alter table(:tickets) do
      add :image, :string, null: false
    end
  end
end
