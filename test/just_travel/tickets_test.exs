defmodule JustTravel.TicketsTest do
  use JustTravel.DataCase

  alias JustTravel.Repo
  alias JustTravel.Tickets

  describe "tickets" do
    alias JustTravel.Tickets.Ticket

    import JustTravel.{LocationsFixtures, TicketsFixtures}

    @invalid_attrs %{name: nil, date: nil, description: nil, price: nil, location_id: nil}

    setup do
      location = location_fixture()
      ticket = ticket_fixture(location_id: location.id)
      {:ok, ticket: ticket, location: location}
    end

    test "list_tickets/0 returns all tickets" do
      %{entries: tickets, metadata: _metadata} = Tickets.list_tickets()
      assert length(tickets) == 1
    end

    test "get_ticket/1 returns the ticket with given id", %{ticket: ticket} do
      ticket = Repo.preload(ticket, :location)
      assert {:ok, %Ticket{}} = Tickets.get_ticket(ticket.id)
    end

    test "create_ticket/1 with valid data creates a ticket", %{location: location} do
      valid_attrs = %{
        name: "some name",
        date: ~D[2023-09-03],
        description: "some description",
        image: "/images/image.jpg",
        price: 100.0,
        adults: 2,
        child_price: 50.0,
        childs: 2,
        location_id: location.id
      }

      assert {:ok, %Ticket{} = ticket} = Tickets.create_ticket(valid_attrs)
      assert ticket.name == "some name"
      assert ticket.date == ~D[2023-09-03]
      assert ticket.description == "some description"
      assert ticket.image == "/images/image.jpg"
      assert ticket.price == Decimal.new("100.0")
      assert ticket.adults == 2
      assert ticket.childs == 2
      assert ticket.child_price == Decimal.new("50.0")
    end

    test "create_ticket/1 with only adult price should create a ticket", %{location: location} do
      valid_attrs = %{
        name: "some name",
        date: ~D[2023-09-03],
        description: "some description",
        image: "/images/image.jpg",
        price: 100.0,
        adults: 2,
        location_id: location.id
      }

      assert {:ok, %Ticket{} = ticket} = Tickets.create_ticket(valid_attrs)
      assert ticket.name == "some name"
      assert ticket.date == ~D[2023-09-03]
      assert ticket.description == "some description"
      assert ticket.image == "/images/image.jpg"
      assert ticket.price == Decimal.new("100.0")
      assert ticket.adults == 2
      assert ticket.childs == nil
      assert ticket.child_price == nil
    end

    test "create_ticket/1 with only child price should create a ticket", %{location: location} do
      valid_attrs = %{
        name: "some name",
        date: ~D[2023-09-03],
        description: "some description",
        image: "/images/image.jpg",
        child_price: 100.0,
        childs: 2,
        location_id: location.id
      }

      assert {:ok, %Ticket{} = ticket} = Tickets.create_ticket(valid_attrs)
      assert ticket.name == "some name"
      assert ticket.date == ~D[2023-09-03]
      assert ticket.description == "some description"
      assert ticket.image == "/images/image.jpg"
      assert ticket.child_price == Decimal.new("100.0")
      assert ticket.childs == 2
      assert ticket.price == nil
      assert ticket.adults == nil
    end

    test "create_ticket/1 with only price and without adults should return error", %{
      location: location
    } do
      invalid_attrs = %{
        name: "some name",
        date: ~D[2023-09-03],
        description: "some description",
        image: "/images/image.jpg",
        price: 100.0,
        location_id: location.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Tickets.create_ticket(invalid_attrs)

      assert errors_on(changeset) == %{
               adults: ["can't be blank"]
             }
    end

    test "create_ticket/1 with only price and without childs should return error", %{
      location: location
    } do
      invalid_attrs = %{
        name: "some name",
        date: ~D[2023-09-03],
        description: "some description",
        image: "/images/image.jpg",
        child_price: 100.0,
        location_id: location.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Tickets.create_ticket(invalid_attrs)

      assert errors_on(changeset) == %{
               childs: ["can't be blank"]
             }
    end

    test "create_ticket/1 with only adults info without price should return error", %{
      location: location
    } do
      invalid_attrs = %{
        name: "some name",
        date: ~D[2023-09-03],
        description: "some description",
        image: "/images/image.jpg",
        adults: 2,
        location_id: location.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Tickets.create_ticket(invalid_attrs)

      assert errors_on(changeset) == %{
               price: ["can't be blank"]
             }
    end

    test "create_ticket/1 with only childs info without price should return error", %{
      location: location
    } do
      invalid_attrs = %{
        name: "some name",
        date: ~D[2023-09-03],
        description: "some description",
        image: "/images/image.jpg",
        childs: 2,
        location_id: location.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Tickets.create_ticket(invalid_attrs)

      assert errors_on(changeset) == %{
               child_price: ["can't be blank"]
             }
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Tickets.create_ticket(@invalid_attrs)

      assert errors_on(changeset) == %{
               name: ["can't be blank"],
               date: ["can't be blank"],
               description: ["can't be blank"],
               price: ["or child_price must be present"],
               child_price: ["or price must be present"],
               image: ["can't be blank"],
               location_id: ["can't be blank"]
             }
    end

    test "create_ticket/1 with price less than 0 returns error changeset", %{location: location} do
      invalid_attrs = %{
        name: "some name",
        date: ~D[2023-09-03],
        description: "some description",
        image: "/images/image.jpg",
        price: -100.0,
        location_id: location.id,
        adults: 2
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
      assert {:ok, _ticket} = Tickets.get_ticket(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket", %{ticket: ticket} do
      assert {:ok, %Ticket{}} = Tickets.delete_ticket(ticket)
      assert {:error, "Ticket not found"} = Tickets.get_ticket(ticket.id)
    end
  end
end
