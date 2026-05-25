require "test_helper"

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "next image returns json data" do
    get api_next_image_path,
        params: {
          theme_id: themes(:mobile).id,
          index: 0,
          length: 2
        }

    assert_response :success

    body = JSON.parse(response.body)
    assert_equal "success", body["status"]
    assert body["image_id"].present?
    assert body["image_url"].present?
  end

  test "previous image wraps to last image" do
    get api_prev_image_path,
        params: {
          theme_id: themes(:mobile).id,
          index: 0,
          length: 2
        }

    assert_response :success

    body = JSON.parse(response.body)
    assert_equal "success", body["status"]
    assert body["image_id"].present?
  end
end
