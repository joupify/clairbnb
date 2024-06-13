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
require 'rails_helper'

RSpec.describe CalendarEvent, type: :model do
  context 'validations' do
    it {validate_presence_of(:start_date)}
    it {validate_presence_of(:end_date)}
    it {validate_presence_of(:status)}

  end

  context 'associations' do
    it { should belong_to(:listing) }
    it {should belong_to(:reservation).optional}
  end
end
