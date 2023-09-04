defmodule JustTravel.TicketsTest do
  use JustTravel.DataCase

  alias JustTravel.Tickets

  describe "tickets" do
    alias JustTravel.Tickets.Ticket

    import JustTravel.TicketsFixtures

    @invalid_attrs %{name: nil, date: nil, description: nil}

    setup do
      ticket = ticket_fixture()
      {:ok, ticket: ticket}
    end

    test "list_tickets/0 returns all tickets", %{ticket: ticket} do
      assert Tickets.list_tickets() == [ticket]
    end

    test "get_ticket/1 returns the ticket with given id", %{ticket: ticket} do
      assert Tickets.get_ticket(ticket.id) == {:ok, ticket}
    end

    test "create_ticket/1 with valid data creates a ticket" do
      valid_attrs = %{
        name: "some name",
        date: ~D[2023-09-03],
        description: "some description",
        price: 100.0
      }

      assert {:ok, %Ticket{} = ticket} = Tickets.create_ticket(valid_attrs)
      IO.inspect(ticket)
      assert ticket.name == "some name"
      assert ticket.date == ~D[2023-09-03]
      assert ticket.description == "some description"
      assert ticket.price == Decimal.new("100.0")
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Tickets.create_ticket(@invalid_attrs)

      assert errors_on(changeset) == %{
               name: ["can't be blank"],
               date: ["can't be blank"],
               description: ["can't be blank"],
               price: ["can't be blank"]
             }
    end

    test "create_ticket/1 with price less than 0 returns error changeset" do
      invalid_attrs = %{
        name: "some name",
        date: ~D[2023-09-03],
        description: "some description",
        price: -100.0
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Tickets.create_ticket(invalid_attrs)

      assert errors_on(changeset) == %{
               price: ["must be greater than or equal to 0"]
             }
    end

    test "update_ticket/2 with valid data updates the ticket", %{ticket: ticket} do
      update_attrs = %{
        name: "some updated name",
        date: ~D[2023-09-04],
        description: "some updated description"
      }

      assert {:ok, %Ticket{} = ticket} = Tickets.update_ticket(ticket, update_attrs)
      assert ticket.name == "some updated name"
      assert ticket.date == ~D[2023-09-04]
      assert ticket.description == "some updated description"
    end

    test "update_ticket/2 with invalid data returns error changeset", %{ticket: ticket} do
      assert {:error, %Ecto.Changeset{}} = Tickets.update_ticket(ticket, @invalid_attrs)
      assert {:ok, ticket} == Tickets.get_ticket(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket", %{ticket: ticket} do
      assert {:ok, %Ticket{}} = Tickets.delete_ticket(ticket)
      assert {:error, "Ticket not found"} = Tickets.get_ticket(ticket.id)
    end
  end
end
