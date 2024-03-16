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
  belongs_to :listing
  mount_uploader :image, ImageUploader



end
