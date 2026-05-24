require "application_system_test_case"

class ExpertRatingsTest < ApplicationSystemTestCase
  setup do
    @expert_rating = expert_ratings(:one)
  end

  test "visiting the index" do
    visit expert_ratings_url
    assert_selector "h1", text: "Expert ratings"
  end

  test "should create expert rating" do
    visit expert_ratings_url
    click_on "New expert rating"

    fill_in "Image", with: @expert_rating.image_id
    fill_in "Rating", with: @expert_rating.rating
    fill_in "User", with: @expert_rating.user_id
    click_on "Create Expert rating"

    assert_text "Expert rating was successfully created"
    click_on "Back"
  end

  test "should update Expert rating" do
    visit expert_rating_url(@expert_rating)
    click_on "Edit this expert rating", match: :first

    fill_in "Image", with: @expert_rating.image_id
    fill_in "Rating", with: @expert_rating.rating
    fill_in "User", with: @expert_rating.user_id
    click_on "Update Expert rating"

    assert_text "Expert rating was successfully updated"
    click_on "Back"
  end

  test "should destroy Expert rating" do
    visit expert_rating_url(@expert_rating)
    click_on "Destroy this expert rating", match: :first

    assert_text "Expert rating was successfully destroyed"
  end
end
