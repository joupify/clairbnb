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
FactoryBot.define do
  factory :listing do
    association :host, factory: :host

    title { "Test Listing" }
    address { "123 Test St" }
    city { "Test City" }
    country { "Test Country" }
    description { "A lovely place to stay." }
    postal_code { "12345" }
    max_guests { 4 }
    nightly_price { 100.0 }
    cleaning_fee { 50.0 }
  end
end
