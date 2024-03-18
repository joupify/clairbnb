# == Schema Information
#
# Table name: beds
#
#  id         :bigint           not null, primary key
#  room_id    :bigint           not null
#  bed_size   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class BedTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
