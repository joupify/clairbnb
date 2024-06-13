# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  listing_id :bigint           not null
#  room_type  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Room, type: :model do
  context 'validations' do
    it {should validate_presence_of(:room_type)}
  end
  context 'associations' do
    it {should belong_to(:listing)}
  end
end
