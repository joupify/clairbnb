class Bed < ApplicationRecord
  validates :bed_size, presence: true
  belongs_to :room, counter_cache: true

  enum bed_size: {
  twin: 0,
  twin_xl: 1,
  full: 2,
  queen: 3,
  king: 4,


  }
end
# == Schema Information
#
# Table name: beds
#
#  id         :bigint           not null, primary key
#  room_id    :bigint           not null
#  bed_size   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

