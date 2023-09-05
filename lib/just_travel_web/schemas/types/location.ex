defmodule JustTravelWeb.Schemas.Location do
  @moduledoc false
  use Absinthe.Schema.Notation

  object :location do
    field :name, :string
    field :position, :point
  end

  scalar :point, name: "Point" do
    description("""
    The `Point` scalar type represents Point geographic information compliant string data,
    represented as floats separated by a semi-colon. The geodetic system is WGS 84
    """)

    serialize(&encode/1)
    parse(&decode/1)
  end

  @spec decode(Absinthe.Blueprint.Input.String.t()) :: {:ok, term} | :error
  @spec decode(Absinthe.Blueprint.Input.Null.t()) :: {:ok, nil}
  defp decode(%Absinthe.Blueprint.Input.String{value: value}) do
    with [_, _] = lonlat <- String.split(value, ";", trim: true),
         [{lon, ""}, {lat, ""}] <- Enum.map(lonlat, &Float.parse(&1)) do
      {:ok, %Geo.Point{coordinates: {lon, lat}, srid: 4326}}
    else
      _ -> :error
    end
  end

  defp decode(%Absinthe.Blueprint.Input.Null{}) do
    {:ok, nil}
  end

  defp decode(_) do
    :error
  end

  defp encode(%Geo.Point{coordinates: {lon, lat}}) do
    %{
      longitude: lon,
      latitude: lat
    }
  end
end
