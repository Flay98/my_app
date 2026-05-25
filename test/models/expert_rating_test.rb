require "test_helper"

class ExpertRatingTest < ActiveSupport::TestCase
  test "rating must be between 1 and 10" do
    low_rating = ExpertRating.new(user: users(:admin), image: images(:web_first), rating: 0)
    high_rating = ExpertRating.new(user: users(:admin), image: images(:web_first), rating: 11)

    assert_not low_rating.valid?
    assert_not high_rating.valid?
  end

  test "same user can rate same image only once" do
    duplicate = ExpertRating.new(user: users(:expert), image: images(:mobile_first), rating: 7)

    assert_not duplicate.valid?
    assert duplicate.errors[:user_id].any?
  end

  test "valid rating can be saved" do
    rating = ExpertRating.new(user: users(:expert), image: images(:web_first), rating: 6)

    assert rating.valid?
  end
end
