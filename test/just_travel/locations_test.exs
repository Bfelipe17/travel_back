defmodule JustTravel.LocationsTest do
  use JustTravel.DataCase

  alias JustTravel.Locations

  describe "locations" do
    alias JustTravel.Locations.Location

    import JustTravel.LocationsFixtures
    import JustTravel.TicketsFixtures

    @invalid_attrs %{name: nil, position: nil}

    setup do
      location = location_fixture()
      position = %Geo.Point{coordinates: {0, 0}, srid: 4326}
      {:ok, location: location, position: position}
    end

    test "list_locations/0 returns all locations", %{location: location} do
      assert Locations.list_locations() == [location]
    end

    test "get_location/1 returns the location with given id", %{location: location} do
      assert Locations.get_location(location.id) == {:ok, location}
    end

    test "search_location_by_name/1 returns the location with given name", %{location: location} do
      ticket_fixture(location_id: location.id)
      data = Locations.search_location_by_name(location.name) |> hd()
      assert length(data.tickets) == 1
    end

    test "create_location/1 with valid data creates a location", %{position: position} do
      valid_attrs = %{name: "some name", position: position}

      assert {:ok, %Location{} = location} = Locations.create_location(valid_attrs)
      assert location.name == "some name"
      assert location.position == %Geo.Point{coordinates: {0, 0}, srid: 4326, properties: %{}}
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Locations.create_location(@invalid_attrs)

      assert changeset.errors == [
               name: {"can't be blank", [validation: :required]},
               position: {"can't be blank", [validation: :required]}
             ]
    end

    test "update_location/2 with valid data updates the location", %{location: location} do
      position = %Geo.Point{coordinates: {1, 1}, srid: 4326}
      update_attrs = %{name: "some updated name", position: position}

      assert {:ok, %Location{} = location} = Locations.update_location(location, update_attrs)
      assert location.name == "some updated name"
      assert location.position == %Geo.Point{coordinates: {1, 1}, srid: 4326, properties: %{}}
    end

    test "update_location/2 with invalid data returns error changeset", %{location: location} do
      assert {:error, %Ecto.Changeset{} = changeset} =
               Locations.update_location(location, @invalid_attrs)

      assert errors_on(changeset) == %{name: ["can't be blank"], position: ["can't be blank"]}
      assert {:ok, location} == Locations.get_location(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Locations.delete_location(location)
      assert {:error, "Location not found"} = Locations.get_location(location.id)
    end
  end
end
