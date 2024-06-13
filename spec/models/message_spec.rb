# == Schema Information
#
# Table name: messages
#
#  id             :bigint           not null, primary key
#  from_user_id   :bigint           not null
#  to_user_id     :bigint           not null
#  reservation_id :bigint           not null
#  content        :text             default(""), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'validations' do
    it { should validate_presence_of(:content) }
  end
 
  it "should create a message with valid attributes" do

    user = create(:user)
    host = create(:host)
    guest = create(:user, :guest)
    reservation = create(:reservation, guest: guest)

    message = create(:message, content: "Hello", from_user_id: guest.id, to_user_id: host.id, reservation_id: reservation.id)

    expect(message).to be_valid
    expect(message.content).to eq("Hello")
    expect(message.from_user_id).to eq(guest.id)
    expect(message.to_user_id).to eq(host.id)
  
  end

end
