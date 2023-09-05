defmodule JustTravel.Carts.Item do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cart_items" do
    field :quantity, :integer, default: 1
    belongs_to :cart, JustTravel.Carts.Cart
    belongs_to :ticket, JustTravel.Tickets.Ticket

    timestamps()
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:quantity, :cart_id, :ticket_id])
    |> validate_required([:quantity, :cart_id, :ticket_id])
  end
end
