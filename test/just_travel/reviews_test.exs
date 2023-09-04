defmodule JustTravel.ReviewsTest do
  use JustTravel.DataCase

  alias JustTravel.Reviews

  describe "reviews" do
    alias JustTravel.Reviews.Review

    import JustTravel.ReviewsFixtures

    @invalid_attrs %{comment: nil, score: nil}

    test "list_reviews/0 returns all reviews" do
      review = review_fixture()
      assert Reviews.list_reviews() == [review]
    end

    test "get_review/1 returns the review with given id" do
      review = review_fixture()
      assert Reviews.get_review(review.id) == {:ok, review}
    end

    test "create_review/1 with valid data creates a review" do
      valid_attrs = %{comment: "some comment", score: 10}

      assert {:ok, %Review{} = review} = Reviews.create_review(valid_attrs)
      assert review.comment == "some comment"
      assert review.score == 10
    end

    test "create_view/1 with just score creates a review" do
      valid_attrs = %{score: 9.5}

      assert {:ok, %Review{} = review} = Reviews.create_review(valid_attrs)
      assert review.score == 9.5
      assert review.comment == nil
    end

    test "create_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reviews.create_review(@invalid_attrs)
    end

    test "create_view/1 with score greater than 10 returns error changeset" do
      invalid_attrs = %{score: 11.0}
      assert {:error, %Ecto.Changeset{}} = Reviews.create_review(invalid_attrs)
    end

    test "create_view/1 with score less than 0 returns error changeset" do
      invalid_attrs = %{score: -1.0}
      assert {:error, %Ecto.Changeset{}} = Reviews.create_review(invalid_attrs)
    end

    test "update_review/2 with valid data updates the review" do
      review = review_fixture()
      update_attrs = %{comment: "some updated comment", score: 7}

      assert {:ok, %Review{} = review} = Reviews.update_review(review, update_attrs)
      assert review.comment == "some updated comment"
      assert review.score == 7
    end

    test "update_review/2 with invalid data returns error changeset" do
      review = review_fixture()
      assert {:error, %Ecto.Changeset{}} = Reviews.update_review(review, @invalid_attrs)
      assert {:ok, review} == Reviews.get_review(review.id)
    end

    test "update_review/2 with score greater than 10 returns error changeset" do
      review = review_fixture()
      invalid_attrs = %{score: 11.0}
      assert {:error, %Ecto.Changeset{}} = Reviews.update_review(review, invalid_attrs)
      assert {:ok, review} == Reviews.get_review(review.id)
    end

    test "update_review/2 with score less than 0 returns error changeset" do
      review = review_fixture()
      invalid_attrs = %{score: -1.0}
      assert {:error, %Ecto.Changeset{}} = Reviews.update_review(review, invalid_attrs)
      assert {:ok, review} == Reviews.get_review(review.id)
    end

    test "delete_review/1 deletes the review" do
      review = review_fixture()
      assert {:ok, %Review{}} = Reviews.delete_review(review)
      assert {:error, "Review not found"} == Reviews.get_review(review.id)
    end
  end
end
