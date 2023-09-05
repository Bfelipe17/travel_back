defmodule JustTravel.Reviews.Review do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias JustTravel.Tickets.Ticket

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "reviews" do
    field :comment, :string
    field :score, :float
    belongs_to :ticket, Ticket

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:score, :comment, :ticket_id])
    |> validate_required([:score, :ticket_id])
    |> validate_number(:score, greater_than_or_equal_to: 0, less_than_or_equal_to: 10)
  end
end
