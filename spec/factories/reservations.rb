# == Schema Information
#
# Table name: reservations
#
#  id                       :bigint           not null, primary key
#  listing_id               :bigint           not null
#  guest_id                 :bigint           not null
#  session_id               :string
#  status                   :integer          default("pending")
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  stripe_payment_intent_id :string
#  stripe_refund_id         :string
#
FactoryBot.define do
    factory :reservation do
      association :listing
      association :guest, factory: :user  # Ensure :guest is associated with :user
      association :calendar_event  # Ensure a calendar_event is associated


      
      
    end
  end
  
