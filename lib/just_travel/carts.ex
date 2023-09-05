defmodule JustTravel.Carts do
  @moduledoc false
  import Ecto.Query, warn: false
  alias JustTravel.Repo
  alias JustTravel.Carts.{Cart, Item}

  def create_cart do
    %Cart{}
    |> Repo.insert()
  end

  @doc """
  Gets a single cart.

  ## Examples

      iex> get_cart(123)
      {:ok, %Cart{}}

      iex> get_cart
      {:error, "Cart not found"}

  """
  def get_cart(id) do
    case Repo.get(Cart, id) do
      nil -> {:error, "Cart not found"}
      cart -> {:ok, cart |> Repo.preload([:cart_items, [cart_items: :ticket]])}
    end
  end

  @doc """
  Gets a single cart item.

  ## Examples

      iex> get_item(123)
      {:ok, %Item{}}

      iex> get_item(456)
      {:error, "Item not found"}

  """
  def get_item(id) do
    case Repo.get(Item, id) do
      nil -> {:error, "Item not found"}
      item -> {:ok, item}
    end
  end

  def get_item_by_ticket_id(cart_id, ticket_id) do
    Item
    |> where([item], item.cart_id == ^cart_id and item.ticket_id == ^ticket_id)
    |> Repo.one()
  end

  @doc """
  Add a single cart item.

  ## Examples

    iex> add_item_to_cart(%{cart_id: 1, ticket_id: 1})
    {:ok, %Item{}}

    iex> add_item_to_cart(%{cart_id: 1, ticket_id: 1})
    {:error, "Item not found"}

  """
  def add_item_to_cart(%{cart_id: cart_id, ticket_id: ticket_id}) do
    with {:ok, cart} <- get_cart(cart_id),
         {:ok, ticket} <- JustTravel.Tickets.get_ticket(ticket_id) do
      case get_item_by_ticket_id(cart.id, ticket.id) do
        nil -> create_item(%{cart_id: cart.id, ticket_id: ticket.id})
        item -> update_item_quantity(item)
      end
    end
  end

  def add_item_to_cart(attrs) do
    Item.changeset(%Item{}, attrs)
  end

  defp create_item(%{cart_id: cart_id, ticket_id: ticket_id}) do
    %Item{cart_id: cart_id, ticket_id: ticket_id}
    |> Repo.insert()
  end

  defp update_item_quantity(item) do
    item
    |> Item.changeset(%{quantity: item.quantity + 1})
    |> Repo.update()
  end

  def remove_item_from_cart(item_id) do
    with {:ok, item} <- get_item(item_id),
         {:ok, item} <- Repo.delete(item) do
          get_cart(item.cart_id)
    end
  end
end
