# == Schema Information
#
# Table name: notifications
#
#  id             :bigint           not null, primary key
#  recipient_type :string           not null
#  recipient_id   :bigint           not null
#  type           :string           not null
#  params         :jsonb
#  read_at        :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :notification do
    association :recipient, factory: :user
    type { "Notification" }
    params { { 'reservation_id' => 1 } } # Default params with string keys

  
    
  end
end
