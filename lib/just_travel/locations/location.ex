defmodule JustTravel.Locations.Location do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias JustTravel.Tickets.Ticket

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "locations" do
    field :name, :string
    field :position, Geo.PostGIS.Geometry
    has_many :tickets, Ticket

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :position])
    |> validate_required([:name, :position])
  end
end
