require "test_helper"

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = images(:mobile_first)
  end

  test "guest can view gallery" do
    get images_path(locale: :ru)

    assert_response :success
  end

  test "guest cannot view image details" do
    get image_path(@image, locale: :ru)

    assert_redirected_to signin_path(locale: :ru)
  end

  test "signed in expert can view image details" do
    sign_in_as users(:expert)

    get image_path(@image, locale: :ru)

    assert_response :success
  end

  test "signed in expert can create image" do
    sign_in_as users(:expert)

    assert_difference("Image.count", 1) do
      post images_path(locale: :ru), params: {
        image: {
          task_id: tasks(:mobile_task).id,
          file_name: "mobile_3.jpg",
          description: "Created from test"
        }
      }
    end

    assert_redirected_to image_path(Image.last, locale: :ru)
  end

  test "signed in expert can update image" do
    sign_in_as users(:expert)

    patch image_path(@image, locale: :ru), params: {
      image: { description: "Updated description" }
    }

    assert_redirected_to image_path(@image, locale: :ru)
    assert_equal "Updated description", @image.reload.description
  end

  test "expert cannot destroy image" do
    sign_in_as users(:expert)

    assert_no_difference("Image.count") do
      delete image_path(@image, locale: :ru)
    end

    assert_redirected_to root_path(locale: :ru)
  end

  test "admin can destroy image" do
    sign_in_as users(:admin)
    image = images(:web_first)

    assert_difference("Image.count", -1) do
      delete image_path(image, locale: :ru)
    end

    assert_redirected_to images_path(locale: :ru)
  end
end
