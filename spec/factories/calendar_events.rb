# == Schema Information
#
# Table name: calendar_events
#
#  id             :bigint           not null, primary key
#  listing_id     :bigint           not null
#  reservation_id :bigint
#  status         :integer          not null
#  start_date     :date             not null
#  end_date       :date             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :calendar_event do
    association :listing
    # association :reservation
    status { 0 }
    start_date { Date.today }
    end_date { Date.today + 1 }
     
  end
end
