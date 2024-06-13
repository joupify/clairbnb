require "rails_helper"

RSpec.describe MessageMailer, type: :mailer do
  describe "new_message" do
    let(:to_user) { FactoryBot.create(:user, email: "to_user@example.com") } 
    let(:from_user) { FactoryBot.create(:user, email: "from_user@example.com") }
    let(:message) { FactoryBot.create(:message, to_user: to_user, from_user: from_user) }

    it "renders the headers" do
      mail = MessageMailer.with(message: message).new_message
      expect(mail.subject).to eq("You have a new message from #{message.from_user.email}")
      expect(mail.to).to eq(["to_user@example.com"])
      expect(mail.from).to eq(["from_user@example.com"])
    end
  end
end
