defmodule JustTravel.Tickets do
  @moduledoc """
  The Tickets context.
  """

  import Ecto.Query, warn: false
  alias JustTravel.Repo

  alias JustTravel.Tickets.Ticket

  @doc """
  Returns the list of tickets.

  ## Examples

      iex> list_tickets()
      [%Ticket{}, ...]

  """
  def list_tickets(limit \\ 10, before_cursor \\ nil, after_cursor \\ nil) do
    Ticket
    |> join(:left, [t], r in assoc(t, :reviews))
    |> group_by([t], t.id)
    |> preload([:location])
    |> select([t, r], %{t | review_average: %{score: avg(r.score), total: count(r.id)}})
    |> Repo.paginate(
      include_total_count: true,
      before: before_cursor,
      after: after_cursor,
      cursor_fields: [:inserted_at, :id],
      limit: limit
    )
  end

  @doc """
  Gets a single ticket.

  ## Examples

      iex> get_ticket(123)
      {:ok, %Ticket{}}

      iex> get_ticket(456)
      ** {:error, "Ticket not found"}

  """
  def get_ticket(id) do
    Ticket
    |> where([t], t.id == ^id)
    |> join(:left, [t], r in assoc(t, :reviews))
    |> group_by([t], t.id)
    |> preload([:location])
    |> select([t, r], %{t | review_average: %{score: avg(r.score), total: count(r.id)}})
    |> Repo.one()
    |> case do
      nil -> {:error, "Ticket not found"}
      ticket -> {:ok, ticket}
    end
  end

  @doc """
  Creates a ticket.

  ## Examples

      iex> create_ticket(%{field: value})
      {:ok, %Ticket{}}

      iex> create_ticket(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ticket(attrs) do
    %Ticket{}
    |> Ticket.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ticket.

  ## Examples

      iex> update_ticket(ticket, %{field: new_value})
      {:ok, %Ticket{}}

      iex> update_ticket(ticket, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ticket(%Ticket{} = ticket, attrs) do
    ticket
    |> Ticket.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ticket.

  ## Examples

      iex> delete_ticket(ticket)
      {:ok, %Ticket{}}

      iex> delete_ticket(ticket)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ticket(%Ticket{} = ticket) do
    Repo.delete(ticket)
  end
end
