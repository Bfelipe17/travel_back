defmodule JustTravelWeb.Schema do
  @moduledoc false
  use Absinthe.Schema
  alias JustTravelWeb.Resolvers.Carts, as: CartsResolver
  alias JustTravelWeb.Resolvers.Locations, as: LocationsResolver
  alias JustTravelWeb.Resolvers.Tickets, as: TicketsResolver

  import_types(JustTravelWeb.Schemas.Types.Cart)
  import_types(JustTravelWeb.Schemas.Types.LocationWithTickets)

  query do
    @desc "Get ticket by id"
    field :ticket, type: :ticket do
      arg(:id, non_null(:id))

      resolve(&TicketsResolver.get_ticket/3)
    end

    @desc "List all tickets"
    field :tickets, :page do
      arg(:limit, :integer)
      arg(:after, :string)
      arg(:before, :string)
      resolve(&TicketsResolver.all_tickets/3)
    end

    @desc "List tickets by location"
    field :tickets_by_location, list_of(:location_with_tickets) do
      arg(:location_name, non_null(:string))

      resolve(&LocationsResolver.tickets_by_location/3)
    end

    @desc "Get cart info"
    field :cart, type: :cart do
      arg(:id, non_null(:id))

      resolve(&CartsResolver.get_cart/3)
    end
  end

  mutation do
    @desc "add ticket to cart"
    field :add_ticket_to_cart, type: :cart do
      arg(:cart_id, non_null(:id))
      arg(:ticket_id, non_null(:id))

      resolve(&CartsResolver.add_ticket_to_cart/3)
    end

    @desc "remove ticket from cart"
    field :remove_ticket_from_cart, type: :cart do
      arg(:item_id, non_null(:id))

      resolve(&CartsResolver.remove_ticket_from_cart/3)
    end
  end
end
