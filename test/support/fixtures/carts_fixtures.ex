defmodule JustTravel.CartsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JustTravel.CartsFixtures` context.
  """

  @doc """
  Generate a cart.
  """
  def cart_fixture do
    {:ok, cart} = JustTravel.Carts.create_cart()

    cart
  end
end
