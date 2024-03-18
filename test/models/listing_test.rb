# == Schema Information
#
# Table name: listings
#
#  id                :bigint           not null, primary key
#  host_id           :bigint           not null
#  title             :string           not null
#  description       :string
#  address           :string
#  city              :string
#  postal_code       :string
#  country           :string
#  latitude          :decimal(10, 6)
#  longitude         :decimal(10, 6)
#  max_guests        :integer          default(1)
#  status            :integer          default("draft")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  nightly_price     :integer
#  cleaning_fee      :integer
#  stripe_product_id :string
#
require "test_helper"

class ListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
