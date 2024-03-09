# == Schema Information
#
# Table name: listings
#
#  id              :bigint           not null, primary key
#  host_id         :bigint           not null
#  title           :string           not null
#  description     :string
#  address         :string
#  city            :string
#  postal_code     :string
#  country         :string
#  latitude        :decimal(10, 6)
#  longitude       :decimal(10, 6)
#  max_guests      :integer          default(1)
#  status          :integer          default("draft")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  listing_details :jsonb
#
class Listing < ApplicationRecord
  validates  :title, presence: true
  validates :max_guests, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  belongs_to :host, class_name: 'User'
  enum status: {draft: 0, published: 1, archived:3}

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  
end
