defmodule JustTravelWeb.Schemas.Ticket do
  @moduledoc false
  use Absinthe.Schema.Notation
  import_types(Absinthe.Type.Custom)
  import_types(JustTravelWeb.Schemas.Location)
  import_types(JustTravelWeb.Schemas.Review)

  object :ticket do
    field :id, :id
    field :name, :string
    field :date, :date
    field :description, :string
    field :price, :decimal
    field :discount, :decimal
    field :child_price, :decimal
    field :childs, :integer
    field :adults, :integer
    field :image, :string
    field :location, :location
    field :comodities, list_of(:string)
    field :review_average, :review
  end

  object :page_info do
    field :after, :string
    field :before, :string
    field :limit, :integer
    field :total_count, :integer
    field :total_count_cap_exceeded, :boolean
  end

  object :page do
    field :metadata, :page_info
    field :entries, list_of(:ticket)
  end
end
