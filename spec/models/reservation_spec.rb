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
require 'rails_helper'

RSpec.describe Reservation, type: :model do
  context 'validations' do

  end
  context 'associations' do
    it { should belong_to(:listing)}
    it { should belong_to(:guest)}
    it { should have_one (:calendar_event)}
  end
end
