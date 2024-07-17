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

class User < ApplicationRecord
  validates :email, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable,
        :omniauthable, omniauth_providers: [:google]


  has_many :listings, foreign_key: :host_id
  has_many :reservations, foreign_key: :guest_id
  has_many :host_reservations, class_name: 'Reservation', through: :listings, source: :reservations
  has_many :notifications, as: :recipient, dependent: :destroy

  has_many :webpush_subs, class_name: 'WebpushNotification'
  
  
 has_many :sent_messages, class_name: 'Message', foreign_key: :from_user_id
 has_many :received_messages, class_name: 'Message', foreign_key: :to_user_id

  after_commit :may_be_create_stripe_customer, on: [:create, :update]




  def all_reservations
    Reservation.where(guest: self).or(Reservation.where(listing: listings))
  end

  def may_be_create_stripe_customer
    return if !stripe_customer_id.blank?

    customer = Stripe::Customer.create(
      email: email,
      name: name,
      metadata: {
      clairbnb_id: id
      },

      
    )
    update(stripe_customer_id: customer.id)  #update locally when come back from stripe
  end


  def self.from_omniauth(access_token)
    data = access_token.info
    Rails.logger.debug "User data from OmniAuth: #{data.to_yaml}"
    user = User.where(email: data['email']).first

    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0, 20]
      )
      Rails.logger.debug "Created new user: #{user.to_yaml}"
    else
      Rails.logger.debug "Found existing user: #{user.to_yaml}"
    end
    user
  end
         
end
