defmodule JustTravelWeb.Resolvers.Tickets do
  @moduledoc false
  alias JustTravel.Tickets

  def all_tickets(_, args, _) do
    limit = args[:limit] || 10
    after_cursor = args[:after]
    {:ok, Tickets.list_tickets(limit, nil, after_cursor)}
  end

  def get_ticket(_, %{id: id}, _) do
    Tickets.get_ticket(id)
  end
end
