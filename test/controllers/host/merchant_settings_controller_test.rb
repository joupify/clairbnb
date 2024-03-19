require "test_helper"

class Host::MerchantSettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get host_merchant_settings_index_url
    assert_response :success
  end
end
