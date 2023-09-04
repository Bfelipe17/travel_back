defmodule JustTravel.ReviewsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JustTravel.Reviews` context.
  """

  @doc """
  Generate a review.
  """
  def review_fixture(attrs \\ %{}) do
    {:ok, review} =
      attrs
      |> Enum.into(%{
        comment: "some comment",
        score: 9.5
      })
      |> JustTravel.Reviews.create_review()

    review
  end
end
