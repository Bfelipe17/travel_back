defmodule JustTravel.Carts.Cart do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "carts" do
    has_many :cart_items, JustTravel.Carts.Item

    timestamps()
  end

  def changeset(cart, attrs) do
    cart
    |> cast(attrs, [])
  end
end
