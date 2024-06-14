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

class Listing < ApplicationRecord
  validates :max_guests, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 10  }

  # validates :max_guests, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
  validates :nightly_price, numericality: { greater_than: 0 }
  validates :cleaning_fee, numericality: { greater_than: 0 }
  validates :title, :address, :city, :country, :description, :postal_code, :host, presence: true


  belongs_to :host, class_name: 'User'
  has_many :rooms
  has_many :calendar_events 
  has_many :photos, dependent: :destroy
  has_many :reservations, dependent: :destroy

  accepts_nested_attributes_for :rooms
  accepts_nested_attributes_for :photos, allow_destroy: true

  enum status: {draft: 0, published: 1, archived:3}
  scope :published, -> {where(status: :published)}

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  after_commit :may_be_create_stripe_product, on: [:create, :update]

  def may_be_create_stripe_product
    return if !stripe_product_id.blank?

    # product_images = []

    # photos.each do |photo|
    #   product_images << photo.image_url if photo.image.present?
    # end

    product = Stripe::Product.create(
      name: title,
      url: Rails.application.routes.url_helpers.url_for(self),
      metadata: {
      clairbnb_id: id,
      # images: product_images
      },

      
    )
    update(stripe_product_id: product.id)  #update locally when come back from stripe, check in rails c to confirm
  end

  def unavailable_dates
    calendar_events.pluck(:start_date, :end_date).map { |start_date, end_date| (start_date..end_date).to_a }.flatten
  end
  
  
  
end

