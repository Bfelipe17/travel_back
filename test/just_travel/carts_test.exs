defmodule JustTravel.CartsTest do
  use JustTravel.DataCase

  alias JustTravel.Carts
  alias JustTravel.Carts.{Cart, Item}

  describe "carts" do
    import JustTravel.CartsFixtures
    import JustTravel.TicketsFixtures
    import JustTravel.LocationsFixtures

    setup do
      cart = cart_fixture()
      {:ok, cart: cart}
    end

    test "get_cart/0 return the cart if exists", %{cart: _cart} do
      assert {:ok, %Cart{}} = Carts.get_cart()
    end

    test "get_cart/0 return error if cart does not exists" do
      Repo.delete_all(Cart)
      assert {:error, "Cart not found"} = Carts.get_cart()
    end

    test "add_item_to_cart/1 with valid data insert the item into the cart", %{cart: cart} do
      location = location_fixture()
      ticket = ticket_fixture(location_id: location.id)

      assert {:ok, %Item{}} =
               Carts.add_item_to_cart(%{cart_id: cart.id, ticket_id: ticket.id})
    end

    test "add_item_to_cart/1 duplicate data should update the quantity", %{cart: cart} do
      location = location_fixture()
      ticket = ticket_fixture(location_id: location.id)

      assert {:ok, %Item{}} =
               Carts.add_item_to_cart(%{cart_id: cart.id, ticket_id: ticket.id})

      {:ok, %Cart{cart_items: [%Item{quantity: quantity}]}} = Carts.get_cart()
      assert quantity == 1

      assert {:ok, %Item{}} =
               Carts.add_item_to_cart(%{cart_id: cart.id, ticket_id: ticket.id})

      {:ok, %Cart{cart_items: [%Item{quantity: quantity}]}} = Carts.get_cart()
      assert quantity == 2

      assert {:ok, %Item{}} =
               Carts.add_item_to_cart(%{cart_id: cart.id, ticket_id: ticket.id})

      {:ok, %Cart{cart_items: [%Item{quantity: quantity}]}} = Carts.get_cart()
      assert quantity == 3
    end

    test "add_item_to_cart/1 missing attrs should return an error" do
      assert changeset = Carts.add_item_to_cart(%{})

      assert errors_on(changeset) == %{
               cart_id: ["can't be blank"],
               ticket_id: ["can't be blank"]
             }
    end

    test "add_item_to_cart/1 with invalid data return error", %{cart: cart} do
      assert {:error, "Ticket not found"} =
               Carts.add_item_to_cart(%{
                 cart_id: cart.id,
                 ticket_id: Ecto.UUID.generate(),
                 quantity: 1
               })
    end

    test "remove_item_from_cart/1 with valid data remove the item from the cart", %{cart: cart} do
      location = location_fixture()
      ticket = ticket_fixture(location_id: location.id)

      assert {:ok, %Item{} = item} =
               Carts.add_item_to_cart(%{cart_id: cart.id, ticket_id: ticket.id})

      {:ok, cart} = Carts.get_cart()

      assert length(cart.cart_items) == 1

      assert {:ok, _item} = Carts.remove_item_from_cart(item.id)
      {:ok, cart} = Carts.get_cart()
      assert Enum.empty?(cart.cart_items)
    end

    test "get_item/1 return the item if exists", %{cart: cart} do
      location = location_fixture()
      ticket = ticket_fixture(location_id: location.id)

      assert {:ok, %Item{} = item} =
               Carts.add_item_to_cart(%{cart_id: cart.id, ticket_id: ticket.id})

      assert {:ok, %Item{}} = Carts.get_item(item.id)
    end

    test "get_item/1 return error if item does not exists" do
      assert {:error, "Item not found"} = Carts.get_item(Ecto.UUID.generate())
    end
  end
end
