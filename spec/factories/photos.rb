# == Schema Information
#
# Table name: photos
#
#  id         :bigint           not null, primary key
#  listing_id :bigint           not null
#  image      :string
#  caption    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :photo do
    association :listing
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/fixtures/test_image.jpg'), 'image/jpeg') }
    caption { "Sample caption" }

  end
end
