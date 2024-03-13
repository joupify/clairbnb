class Bed < ApplicationRecord
  belongs_to :room

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
#  id         :integer(8)      not null, primary key
#  room_id    :integer(8)      not null
#  bed_size   :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

