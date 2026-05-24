require "test_helper"

class ExpertRatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @expert_rating = expert_ratings(:one)
  end

  test "should get index" do
    get expert_ratings_url
    assert_response :success
  end

  test "should get new" do
    get new_expert_rating_url
    assert_response :success
  end

  test "should create expert_rating" do
    assert_difference("ExpertRating.count") do
      post expert_ratings_url, params: { expert_rating: { image_id: @expert_rating.image_id, rating: @expert_rating.rating, user_id: @expert_rating.user_id } }
    end

    assert_redirected_to expert_rating_url(ExpertRating.last)
  end

  test "should show expert_rating" do
    get expert_rating_url(@expert_rating)
    assert_response :success
  end

  test "should get edit" do
    get edit_expert_rating_url(@expert_rating)
    assert_response :success
  end

  test "should update expert_rating" do
    patch expert_rating_url(@expert_rating), params: { expert_rating: { image_id: @expert_rating.image_id, rating: @expert_rating.rating, user_id: @expert_rating.user_id } }
    assert_redirected_to expert_rating_url(@expert_rating)
  end

  test "should destroy expert_rating" do
    assert_difference("ExpertRating.count", -1) do
      delete expert_rating_url(@expert_rating)
    end

    assert_redirected_to expert_ratings_url
  end
end
