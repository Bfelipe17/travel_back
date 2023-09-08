defmodule JustTravelWeb.Resolvers.Carts do
  @moduledoc false
  alias JustTravel.Carts

  def get_cart(_, %{id: _id}, _) do
    Carts.get_cart()
  end

  def add_ticket_to_cart(_, %{cart_id: cart_id, ticket_id: ticket_id}, _) do
    Carts.add_item_to_cart(%{cart_id: cart_id, ticket_id: ticket_id})
    Carts.get_cart()
  end

  def remove_ticket_from_cart(_, %{item_id: item_id}, _) do
    Carts.remove_item_from_cart(item_id)
  end
end
