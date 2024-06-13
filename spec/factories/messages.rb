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
FactoryBot.define do
  factory :message do
    association :from_user, factory: :user
    association :to_user, factory: :user
    association :reservation, factory: :reservation
    content { "MyText" }
    
  end
end
