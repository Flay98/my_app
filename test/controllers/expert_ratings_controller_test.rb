require "test_helper"

class ExpertRatingsControllerTest < ActionDispatch::IntegrationTest
  test "signed in user can create rating" do
    sign_in_as users(:expert)

    assert_difference("ExpertRating.count", 1) do
      post expert_ratings_path(locale: :ru), params: {
        theme_id: themes(:web).id,
        current_index: 0,
        expert_rating: {
          image_id: images(:web_first).id,
          rating: 7
        }
      }
    end

    assert_redirected_to work_path(locale: :ru, theme_id: themes(:web).id, index: "0")
  end

  test "signed in user updates existing rating for same image" do
    sign_in_as users(:expert)

    assert_no_difference("ExpertRating.count") do
      post expert_ratings_path(locale: :ru), params: {
        theme_id: themes(:mobile).id,
        current_index: 0,
        expert_rating: {
          image_id: images(:mobile_first).id,
          rating: 5
        }
      }
    end

    assert_equal 5, expert_ratings(:expert_mobile_first).reload.rating
  end
end
