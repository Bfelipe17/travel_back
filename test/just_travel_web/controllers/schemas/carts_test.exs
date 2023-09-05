defmodule JustTravelWeb.Schemas.CartsTest do
  use JustTravelWeb.ConnCase

  import JustTravel.LocationsFixtures
  import JustTravel.TicketsFixtures
  import JustTravel.CartsFixtures

  @cart_query """
  query getCart($id: ID!) {
    cart(id: $id) {
      id
      cartItems {
        id
        quantity
        ticket {
          id
          name
          description
          adults
          price
          childs
          childPrice
          date
          discount
        }
      }
    }
  }
  """

  @cart_add_mutation """
  mutation addTicketToCart($cartId: ID!, $ticketId: ID!) {
    addTicketToCart(cartId: $cartId, ticketId: $ticketId) {
      id
      cartItems {
        id
        quantity
        ticket {
          id
          name
          description
          adults
          price
          childs
          childPrice
          date
          discount
        }
      }
    }
  }
  """

  @cart_remove_item_mutation """
  mutation removeTicketFromCart($itemId: ID!) {
    removeTicketFromCart(itemId: $itemId) {
      id
      cartItems {
        id
        quantity
        ticket {
          id
          name
          description
          adults
          price
          childs
          childPrice
          date
          discount
        }
      }
    }
  }
  """

  test "query: cart should return nothing if no cart is registered", %{conn: conn} do
    conn =
      post(conn, "/api/graphql", %{
        "query" => @cart_query,
        "variables" => %{
          "id" => Ecto.UUID.generate()
        }
      })

    assert json_response(conn, 200) == %{
             "data" => %{"cart" => nil},
             "errors" => [
               %{
                 "locations" => [%{"column" => 3, "line" => 2}],
                 "message" => "Cart not found",
                 "path" => ["cart"]
               }
             ]
           }
  end

  test "query: cart should return a registered cart", %{conn: conn} do
    cart = cart_fixture()
    location = location_fixture()
    ticket = ticket_fixture(location_id: location.id)
    JustTravel.Carts.add_item_to_cart(%{cart_id: cart.id, ticket_id: ticket.id})

    conn =
      post(conn, "/api/graphql", %{
        "query" => @cart_query,
        "variables" => %{
          "id" => cart.id
        }
      })

    %{"data" => %{"cart" => %{"cartItems" => cart_items}}} = json_response(conn, 200)

    assert length(cart_items) == 1
  end

  test "mutation: add ticket to cart should return a registered cart", %{conn: conn} do
    cart = cart_fixture()
    location = location_fixture()
    ticket = ticket_fixture(location_id: location.id)

    conn =
      post(conn, "/api/graphql", %{
        "query" => @cart_add_mutation,
        "variables" => %{
          "cartId" => cart.id,
          "ticketId" => ticket.id,
          "quantity" => 1
        }
      })

    %{"data" => %{"addTicketToCart" => %{"cartItems" => cart_items}}} = json_response(conn, 200)

    assert length(cart_items) == 1
  end

  test "mutation: remove ticket from cart should return a registered cart", %{conn: conn} do
    cart = cart_fixture()
    location = location_fixture()
    ticket = ticket_fixture(location_id: location.id)

    create_conn =
      post(conn, "/api/graphql", %{
        "query" => @cart_add_mutation,
        "variables" => %{
          "cartId" => cart.id,
          "ticketId" => ticket.id,
          "quantity" => 1
        }
      })

    %{"data" => %{"addTicketToCart" => %{"cartItems" => [%{"id" => item_id}] = cart_items}}} =
      json_response(create_conn, 200)

    assert length(cart_items) == 1

    conn =
      post(conn, "/api/graphql", %{
        "query" => @cart_remove_item_mutation,
        "variables" => %{
          "itemId" => item_id
        }
      })

    %{"data" => %{"removeTicketFromCart" => %{"cartItems" => cart_items}}} =
      json_response(conn, 200)

    assert Enum.empty?(cart_items)
  end
end
