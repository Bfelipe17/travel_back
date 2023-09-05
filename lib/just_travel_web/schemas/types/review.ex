defmodule JustTravelWeb.Schemas.Review do
  @moduledoc false
  use Absinthe.Schema.Notation

  object :review do
    field :total, :integer
    field :score, :float
  end
end
