require "test_helper"

class ImageTest < ActiveSupport::TestCase
  test "image belongs to task and theme through task" do
    image = images(:mobile_first)

    assert_equal tasks(:mobile_task), image.task
    assert_equal themes(:mobile), image.theme
  end

  test "by_theme returns only images from selected theme" do
    mobile_images = Image.by_theme(themes(:mobile).id)

    assert_includes mobile_images, images(:mobile_first)
    assert_includes mobile_images, images(:mobile_second)
    assert_not_includes mobile_images, images(:web_first)
  end

  test "average rating returns rounded value" do
    image = images(:mobile_first)

    assert_equal 8.5, image.average_rating.to_f
  end

  test "average rating text handles images without ratings" do
    assert_equal "Нет оценок", images(:web_first).average_rating_text
  end
end
