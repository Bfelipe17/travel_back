defmodule JustTravelWeb.Schemas.Types.LocationWithTickets do
  @moduledoc false
  use Absinthe.Schema.Notation
  import_types(JustTravelWeb.Schemas.Ticket)

  object :location_with_tickets do
    field :location, :location
    field :tickets, list_of(:ticket)
  end
end
