defmodule JustTravel.Tickets.Ticket do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias JustTravel.Locations.Location
  alias JustTravel.Reviews.Review

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tickets" do
    field :name, :string
    field :date, :date
    field :description, :string
    field :price, :decimal
    field :discount, :decimal
    field :child_price, :decimal
    field :adults, :integer
    field :childs, :integer
    field :image, :string
    field :comodities, {:array, :string}
    belongs_to :location, Location
    has_many :reviews, Review, on_delete: :delete_all

    field :review_average, :map, virtual: true

    timestamps()
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [
      :name,
      :description,
      :date,
      :price,
      :discount,
      :child_price,
      :adults,
      :comodities,
      :childs,
      :image,
      :location_id
    ])
    |> validate_required([:name, :description, :date, :image, :location_id])
    |> validate_price_or_child_price_present()
    |> validate_adults()
    |> validate_childs()
    |> validate_number(:discount, greater_than_or_equal_to: 0)
    |> validate_number(:discount, less_than_or_equal_to: 100)
    |> validate_number(:child_price, greater_than_or_equal_to: 0)
  end

  defp validate_price_or_child_price_present(changeset) do
    price = get_field(changeset, :price)
    adult_price = get_field(changeset, :adults)
    child_price = get_field(changeset, :child_price)
    childs = get_field(changeset, :childs)

    if is_nil(price) && is_nil(child_price) && is_nil(adult_price) && is_nil(childs) do
      changeset
      |> add_error(:price, "or child_price must be present")
      |> add_error(:child_price, "or price must be present")
    else
      changeset
    end
  end

  defp validate_adults(%Ecto.Changeset{changes: %{price: _price}} = changeset) do
    changeset
    |> validate_required([:adults])
    |> validate_number(:adults, greater_than_or_equal_to: 0)
    |> validate_number(:price, greater_than_or_equal_to: 0)
  end

  defp validate_adults(%Ecto.Changeset{changes: %{adults: _adults}} = changeset) do
    changeset
    |> validate_required([:price])
    |> validate_number(:adults, greater_than_or_equal_to: 0)
    |> validate_number(:price, greater_than_or_equal_to: 0)
  end

  defp validate_adults(changeset), do: changeset

  defp validate_childs(%Ecto.Changeset{changes: %{child_price: _child_price}} = changeset) do
    changeset
    |> validate_required([:childs])
    |> validate_number(:childs, greater_than_or_equal_to: 0)
    |> validate_number(:child_price, greater_than_or_equal_to: 0)
  end

  defp validate_childs(%Ecto.Changeset{changes: %{childs: _childs}} = changeset) do
    changeset
    |> validate_required([:child_price])
    |> validate_number(:adults, greater_than_or_equal_to: 0)
    |> validate_number(:price, greater_than_or_equal_to: 0)
  end

  defp validate_childs(changeset), do: changeset
end
