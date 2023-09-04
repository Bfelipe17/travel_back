defmodule JustTravel.TicketsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JustTravel.Tickets` context.
  """

  @doc """
  Generate a ticket.
  """
  def ticket_fixture(attrs \\ %{}) do
    {:ok, ticket} =
      attrs
      |> Enum.into(%{
        name: "some name",
        date: ~D[2023-09-03],
        description: "some description",
        price: 100.0
      })
      |> JustTravel.Tickets.create_ticket()

    ticket
  end
end
