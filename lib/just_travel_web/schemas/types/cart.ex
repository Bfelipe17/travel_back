defmodule JustTravelWeb.Schemas.Types.Cart do
  @moduledoc false
  use Absinthe.Schema.Notation

  object :cart do
    field :id, :id
    field :cart_items, list_of(:cart_item)
  end

  object :cart_item do
    field :id, :id
    field :quantity, :integer
    field :ticket, :ticket
  end
end
