# == Schema Information
#
# Table name: events
#
#  id            :bigint           not null, primary key
#  request_body  :text
#  status        :integer          default("pending")
#  source        :string
#  error_message :text
#  event_type    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
