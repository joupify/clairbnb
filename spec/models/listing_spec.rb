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
require 'rails_helper'

RSpec.describe Listing, type: :model do
  context 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:postal_code)}
    it {should validate_presence_of(:country)}

    it { should validate_numericality_of(:nightly_price).is_greater_than(0) }
    it { should validate_numericality_of(:cleaning_fee).is_greater_than(0) }
    
    it { should validate_presence_of(:max_guests) }
    it { should validate_numericality_of(:max_guests).is_greater_than(0)}
    it { should validate_numericality_of(:max_guests).is_less_than_or_equal_to(10)}

  end
  context 'associations' do
    it { should belong_to(:host)}
    it { should have_many(:reservations)}
    it { should have_many(:calendar_events)}
    it { should have_many(:photos)}
    it { should have_many(:rooms)}

  end
end
