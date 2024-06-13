# == Schema Information
#
# Table name: notifications
#
#  id             :bigint           not null, primary key
#  recipient_type :string           not null
#  recipient_id   :bigint           not null
#  type           :string           not null
#  params         :jsonb
#  read_at        :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Notification, type: :model do
  it "should create a notification when reservation is created" do
    host = create(:host)
    listing = create(:listing, host: host)
    guest = create(:user, :guest)  # Create a guest user
    
    # Create calendar_event and associate it with the reservation
    calendar_event = create(:calendar_event, listing: listing)
    
    # Create reservation with calendar_event
    reservation = create(:reservation, guest: guest, listing: listing, calendar_event: calendar_event)
    
    # Create notification
    notification = create(:notification, recipient: guest, params: { reservation_id: reservation.id })
    
    expect(Notification.count).to eq(1)
    expect(notification.recipient).to eq(guest)
    expect(notification.params).to include(reservation_id: reservation.id)
  end
end
