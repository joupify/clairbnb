# == Schema Information
#
# Table name: calendar_events
#
#  id             :bigint           not null, primary key
#  listing_id     :bigint           not null
#  reservation_id :bigint
#  status         :integer          not null
#  start_date     :date             not null
#  end_date       :date             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class CalendarEvent < ApplicationRecord
  belongs_to :listing
  belongs_to :reservation, optional: true

  validates :status, presence: :true
  enum status: { reserved: 0, blocked: 1} # blocked means manually held by the host
end
