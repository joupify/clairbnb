# == Schema Information
#
# Table name: webpush_notifications
#
#  id         :bigint           not null, primary key
#  endpoint   :string
#  auth_key   :string
#  p256dh_key :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
require "test_helper"

class WebpushNotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
