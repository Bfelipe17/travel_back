defmodule JustTravel.ReviewsTest do
  use JustTravel.DataCase

  alias JustTravel.Reviews

  describe "reviews" do
    alias JustTravel.Reviews.Review

    import JustTravel.{LocationsFixtures, ReviewsFixtures, TicketsFixtures}

    @invalid_attrs %{comment: nil, score: nil}

    setup do
      location = location_fixture()
      ticket = ticket_fixture(location_id: location.id)
      review = review_fixture(ticket_id: ticket.id)
      {:ok, ticket: ticket, review: review}
    end

    test "list_reviews/0 returns all reviews", %{review: review} do
      assert Reviews.list_reviews() == [review]
    end

    test "get_review/1 returns the review with given id", %{review: review} do
      assert Reviews.get_review(review.id) == {:ok, review}
    end

    test "create_review/1 with valid data creates a review", %{ticket: ticket} do
      valid_attrs = %{comment: "some comment", score: 10, ticket_id: ticket.id}

      assert {:ok, %Review{} = review} = Reviews.create_review(valid_attrs)
      assert review.comment == "some comment"
      assert review.score == 10
    end

    test "create_view/1 with just score creates a review", %{ticket: ticket} do
      valid_attrs = %{score: 9.5, ticket_id: ticket.id}

      assert {:ok, %Review{} = review} = Reviews.create_review(valid_attrs)
      assert review.score == 9.5
      assert review.comment == nil
    end

    test "create_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Reviews.create_review(@invalid_attrs)
      assert errors_on(changeset) == %{score: ["can't be blank"], ticket_id: ["can't be blank"]}
    end

    test "create_view/1 with score greater than 10 returns error changeset", %{ticket: ticket} do
      invalid_attrs = %{score: 11.0, ticket_id: ticket.id}
      assert {:error, %Ecto.Changeset{} = changeset} = Reviews.create_review(invalid_attrs)
      assert errors_on(changeset) == %{score: ["must be less than or equal to 10"]}
    end

    test "create_view/1 with score less than 0 returns error changeset", %{ticket: ticket} do
      invalid_attrs = %{score: -1.0, ticket_id: ticket.id}
      assert {:error, %Ecto.Changeset{} = changeset} = Reviews.create_review(invalid_attrs)
      assert errors_on(changeset) == %{score: ["must be greater than or equal to 0"]}
    end

    test "update_review/2 with valid data updates the review", %{review: review} do
      update_attrs = %{comment: "some updated comment", score: 7}

      assert {:ok, %Review{} = review} = Reviews.update_review(review, update_attrs)
      assert review.comment == "some updated comment"
      assert review.score == 7
    end

    test "update_review/2 with invalid data returns error changeset", %{review: review} do
      assert {:error, %Ecto.Changeset{}} = Reviews.update_review(review, @invalid_attrs)
      assert {:ok, review} == Reviews.get_review(review.id)
    end

    test "update_review/2 with score greater than 10 returns error changeset", %{review: review} do
      invalid_attrs = %{score: 11.0}

      assert {:error, %Ecto.Changeset{} = changeset} =
               Reviews.update_review(review, invalid_attrs)

      assert errors_on(changeset) == %{score: ["must be less than or equal to 10"]}
      assert {:ok, review} == Reviews.get_review(review.id)
    end

    test "update_review/2 with score less than 0 returns error changeset", %{review: review} do
      invalid_attrs = %{score: -1.0}

      assert {:error, %Ecto.Changeset{} = changeset} =
               Reviews.update_review(review, invalid_attrs)

      assert errors_on(changeset) == %{score: ["must be greater than or equal to 0"]}
      assert {:ok, review} == Reviews.get_review(review.id)
    end

    test "delete_review/1 deletes the review", %{review: review} do
      assert {:ok, %Review{}} = Reviews.delete_review(review)
      assert {:error, "Review not found"} == Reviews.get_review(review.id)
    end
  end
end
