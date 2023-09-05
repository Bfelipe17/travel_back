defmodule JustTravelWeb.Schemas.TicketsTest do
  use JustTravelWeb.ConnCase

  import JustTravel.LocationsFixtures
  import JustTravel.TicketsFixtures

  @tickets_query """
  query {
    tickets {
      entries {
        name
        description
        date
        price
        location {
          name
          position
        }
      }
      metadata {
        after
        before
        limit
        totalCount
      }
    }
  }
  """

  @ticket_query """
  query($id: ID!) {
    ticket(id: $id) {
      name
      description
      date
      price
      location {
        name
        position
      }
    }
  }
  """

  @tickets_by_location_query """
  query {
    ticketsByLocation(locationName: "Brazil") {
  		tickets{
       name
      description
      date
      price
      location {
        name
        position
      }
      }
    }
  }
  """

  test "query: tickets should return nothing if no ticket is registered", %{conn: conn} do
    conn =
      post(conn, "/api/graphql", %{
        "query" => @tickets_query
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "tickets" => %{
                 "entries" => [],
                 "metadata" => %{
                   "after" => nil,
                   "before" => nil,
                   "limit" => 10,
                   "totalCount" => 0
                 }
               }
             }
           }
  end

  test "query: tickets should return all tickets and the pagination data", %{conn: conn} do
    location = location_fixture()
    ticket_fixture(location_id: location.id)

    conn =
      post(conn, "/api/graphql", %{
        "query" => @tickets_query
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "tickets" => %{
                 "entries" => [
                   %{
                     "date" => "2023-09-03",
                     "description" => "some description",
                     "location" => %{
                       "name" => "some name",
                       "position" => %{"latitude" => 0.0, "longitude" => 0.0}
                     },
                     "name" => "some name",
                     "price" => "100.0"
                   }
                 ],
                 "metadata" => %{
                   "after" => nil,
                   "before" => nil,
                   "limit" => 10,
                   "totalCount" => 1
                 }
               }
             }
           }
  end

  test "query: ticket should return a registered ticket", %{conn: conn} do
    location = location_fixture()
    ticket = ticket_fixture(location_id: location.id)

    conn =
      post(conn, "/api/graphql", %{
        "query" => @ticket_query,
        "variables" => %{
          "id" => ticket.id
        }
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "ticket" => %{
                 "name" => ticket.name,
                 "date" => "2023-09-03",
                 "description" => ticket.description,
                 "price" => "100.0",
                 "location" => %{
                   "name" => location.name,
                   "position" => %{"latitude" => 0.0, "longitude" => 0.0}
                 }
               }
             }
           }
  end

  test "query: ticket should return an error if ticket is not registered", %{conn: conn} do
    conn =
      post(conn, "/api/graphql", %{
        "query" => @ticket_query,
        "variables" => %{
          "id" => Ecto.UUID.generate()
        }
      })

    assert json_response(conn, 200) == %{
             "data" => %{"ticket" => nil},
             "errors" => [
               %{
                 "locations" => [%{"column" => 3, "line" => 2}],
                 "message" => "Ticket not found",
                 "path" => ["ticket"]
               }
             ]
           }
  end

  test "query: tickets_by_location should return tickets associated", %{conn: conn} do
    location = location_fixture(name: "Brazil")
    location_2 = location_fixture(name: "Russia")
    ticket_fixture(location_id: location.id)
    ticket_fixture(location_id: location.id)
    ticket_fixture(location_id: location_2.id)

    conn =
      post(conn, "/api/graphql", %{
        "query" => @tickets_by_location_query
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "ticketsByLocation" => [
                 %{
                   "tickets" => [
                     %{
                       "date" => "2023-09-03",
                       "description" => "some description",
                       "location" => %{"name" => nil, "position" => nil},
                       "name" => "some name",
                       "price" => "100.0"
                     },
                     %{
                       "date" => "2023-09-03",
                       "description" => "some description",
                       "location" => %{"name" => nil, "position" => nil},
                       "name" => "some name",
                       "price" => "100.0"
                     }
                   ]
                 }
               ]
             }
           }
  end
end
