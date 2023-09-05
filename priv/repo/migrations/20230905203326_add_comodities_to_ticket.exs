defmodule JustTravel.Repo.Migrations.AddComoditiesToTicket do
  use Ecto.Migration

  def change do
    alter table(:tickets) do
      # comodities should be a list of strings
      add :comodities, {:array, :string}
    end
  end
end
