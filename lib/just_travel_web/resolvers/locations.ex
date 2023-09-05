defmodule JustTravelWeb.Resolvers.Locations do
  @moduledoc false
  alias JustTravel.Locations

  def tickets_by_location(_, %{location_name: location_name}, _) do
    {:ok, Locations.search_location_by_name(location_name)}
  end
end
