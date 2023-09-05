defmodule JustTravel.Locations do
  @moduledoc """
  The Locations context.
  """

  import Ecto.Query, warn: false
  alias JustTravel.Repo

  alias JustTravel.Locations.Location

  @doc """
  Returns the list of locations.

  ## Examples

      iex> list_locations()
      [%Location{}, ...]

  """
  def list_locations do
    Repo.all(Location)
  end

  @doc """
  Gets a single location.

  ## Examples

      iex> get_location(123)
      {:ok, %Location{}}

      iex> get_location!(456)
      {:error, "Location not found"}

  """
  def get_location(id) do
    case Repo.get(Location, id) do
      nil -> {:error, "Location not found"}
      location -> {:ok, location}
    end
  end

  def search_location_by_name(location_name) do
    Location
    |> where([l], ilike(l.name, ^"%#{location_name}%"))
    |> preload(:tickets)
    |> Repo.all()
  end

  @doc """
  Creates a location.

  ## Examples

      iex> create_location(%{field: value})
      {:ok, %Location{}}

      iex> create_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location(attrs) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a location.

  ## Examples

      iex> update_location(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update_location(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a location.

  ## Examples

      iex> delete_location(location)
      {:ok, %Location{}}

      iex> delete_location(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end
end
