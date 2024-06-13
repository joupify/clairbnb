require "rails_helper"

RSpec.describe ReservationMailer, type: :mailer do
  describe "host_booked" do
    let(:host) { FactoryBot.create(:user, email: "host@example.com") }
    let(:guest) { FactoryBot.create(:user, email: "guest@example.com") }
    let(:listing) { FactoryBot.create(:listing, host: host) }
    let(:calendar_event) { FactoryBot.create(:calendar_event, listing: listing) }
    let(:reservation) { FactoryBot.create(:reservation, guest: guest, listing: listing, calendar_event: calendar_event) }

    it "renders the headers" do
      mail = ReservationMailer.with(reservation: reservation).host_booked
      expect(mail.subject).to eq("Your have a new reservation")
      expect(mail.to).to eq(["host@example.com"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      mail = ReservationMailer.with(reservation: reservation).host_booked
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "guest_booked" do
    let(:host) { FactoryBot.create(:user, email: "guest@example.com") }
    let(:guest) { FactoryBot.create(:user, email: "host@example.com") }
    let(:listing) { FactoryBot.create(:listing, host: host) }
    let(:calendar_event) { FactoryBot.create(:calendar_event, listing: listing) }
    let(:reservation) { FactoryBot.create(:reservation, guest: guest, listing: listing, calendar_event: calendar_event) }

    it "renders the headers" do
      mail = ReservationMailer.with(reservation: reservation).guest_booked
      expect(mail.subject).to eq("Your reservation is confirmed")
      expect(mail.to).to eq(["host@example.com"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      mail = ReservationMailer.with(reservation: reservation).guest_booked
      expect(mail.body.encoded).to match("Hi")
    end
  end
end
