# == Schema Information
#
# Table name: listings
#
#  id          :bigint           not null, primary key
#  host_id     :bigint           not null
#  title       :string           not null
#  description :string
#  adress      :string
#  city        :string
#  postal_code :string
#  country     :string
#  lat         :decimal(10, 6)
#  lng         :decimal(10, 6)
#  max_guests  :integer          default(1)
#  status      :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class ListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
