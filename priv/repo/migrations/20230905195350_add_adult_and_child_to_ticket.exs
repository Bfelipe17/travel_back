defmodule JustTravel.Repo.Migrations.AddAdultAndChildToTicket do
  use Ecto.Migration

  def change do
    alter table(:tickets) do
      add :childs, :integer
      add :adults, :integer
    end
  end
end
