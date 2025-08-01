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
class Photo < ApplicationRecord
  belongs_to :listing, counter_cache: true
  mount_uploader :image, ImageUploader



  def image_path
    Rails.root.join('app', 'assets', 'images', image)
  end

end

