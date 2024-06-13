# == Schema Information
#
# Table name: messages
#
#  id             :bigint           not null, primary key
#  from_user_id   :bigint           not null
#  to_user_id     :bigint           not null
#  reservation_id :bigint           not null
#  content        :text             default(""), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "test_helper"

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
