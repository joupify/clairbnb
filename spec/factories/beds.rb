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
FactoryBot.define do
  factory :bed do
    association :room, factory: :room
    
  end
end
