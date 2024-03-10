require "test_helper"

class Host::RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get host_rooms_index_url
    assert_response :success
  end
end
