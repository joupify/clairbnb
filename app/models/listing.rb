# == Schema Information
#
# Table name: listings
#
#  id          :integer(8)      not null, primary key
#  host_id     :integer(8)      not null
#  title       :string          not null
#  description :string
#  address     :string
#  city        :string
#  postal_code :string
#  country     :string
#  latitude    :decimal(10, 6)
#  longitude   :decimal(10, 6)
#  max_guests  :integer(4)      default("1")
#  status      :integer(4)      default("0")
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Listing < ApplicationRecord
  validates  :title, presence: true
  validates :max_guests, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  belongs_to :host, class_name: 'User'
  has_many :rooms
  accepts_nested_attributes_for :rooms
  has_many :beds, dependent: :destroy

  enum status: {draft: 0, published: 1, archived:3}
  scope :published, -> {where(status: :published)}

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  
end

