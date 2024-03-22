require "test_helper"

class Host::ReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get host_reservations_index_url
    assert_response :success
  end
end
