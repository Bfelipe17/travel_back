defmodule JustTravelWeb.Schemas.LocationsTest do
  use JustTravelWeb.ConnCase

  import JustTravel.LocationsFixtures
  import JustTravel.TicketsFixtures

  @location_query """
  query {
    ticketsByLocation(locationName: "São") {
      tickets {
        id
        name
        date
      }
    }
  }
  """

  test "query: ticketsByLocation should return nothing if no ticket is registered", %{conn: conn} do
    conn =
      post(conn, "/api/graphql", %{
        "query" => @location_query
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "ticketsByLocation" => []
             }
           }
  end

  test "query: ticketsByLocation should return tickets if tickets are registered", %{conn: conn} do
    location = location_fixture(name: "São Paulo")
    ticket = ticket_fixture(location_id: location.id)

    conn =
      post(conn, "/api/graphql", %{
        "query" => @location_query
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "ticketsByLocation" => [
                 %{
                   "tickets" => [
                     %{"date" => "2023-09-03", "id" => ticket.id, "name" => "some name"}
                   ]
                 }
               ]
             }
           }
  end
end
