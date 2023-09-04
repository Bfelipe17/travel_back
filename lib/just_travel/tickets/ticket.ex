defmodule JustTravel.Tickets.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  alias JustTravel.Reviews.Review

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tickets" do
    field :name, :string
    field :date, :date
    field :description, :string
    field :price, :decimal
    has_many :reviews, Review, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:name, :description, :date, :price])
    |> validate_required([:name, :description, :date, :price])
    |> validate_number(:price, greater_than_or_equal_to: 0)
  end
end
