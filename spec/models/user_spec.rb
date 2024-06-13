# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  name                   :string
#  stripe_customer_id     :string
#  is_host                :boolean          default(FALSE)
#  stripe_account_id      :string
#  charges_enabled        :boolean          default(FALSE)
#  phone_number           :string
#  identity_verified      :boolean          default(FALSE)
#
require 'rails_helper'

RSpec.describe User, type: :model do

  context "validations" do
    it { should validate_presence_of(:email)}
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:password)}
    it { should validate_length_of(:password).is_at_least(6) }

  end
  context "associations" do
    it {should have_many(:listings)}
  end
  
end
