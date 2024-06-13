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
FactoryBot.define do
  factory :room do
    association :listing
    
    
  end
end
