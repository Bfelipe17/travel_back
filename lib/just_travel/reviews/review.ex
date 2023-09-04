defmodule JustTravel.Reviews.Review do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "reviews" do
    field :comment, :string
    field :score, :float

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:score, :comment])
    |> validate_required([:score])
    |> validate_number(:score, greater_than_or_equal_to: 0, less_than_or_equal_to: 10)
  end
end
