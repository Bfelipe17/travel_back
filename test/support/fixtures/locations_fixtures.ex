defmodule JustTravel.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JustTravel.Locations` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        name: "some name",
        position: %Geo.Point{coordinates: {0, 0}, srid: 4326}
      })
      |> JustTravel.Locations.create_location()

    location
  end
end
