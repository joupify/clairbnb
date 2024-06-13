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
require 'rails_helper'

RSpec.describe Photo, type: :model do
  include CarrierWave::Test::Matchers

  let(:photo) { FactoryBot.create(:photo) }
  let(:uploader) { ImageUploader.new(photo, :image) }

  before do
    ImageUploader.enable_processing = true
    File.open('spec/support/fixtures/test_image.jpg') { |f| uploader.store!(f) }
  end

  after do
    ImageUploader.enable_processing = false
    uploader.remove!
  end

  it 'uploads an image' do
    expect(uploader).to be_format('png')
    expect(uploader).to have_permissions(0644)
    expect(uploader).to be_no_larger_than(150, 150)
  end

  context "validations" do

  end

  context "associations" do
    it { should belong_to(:listing)}
  end
end
