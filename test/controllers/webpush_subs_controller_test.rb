require "test_helper"

class WebpushSubsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get webpush_subs_index_url
    assert_response :success
  end
end
