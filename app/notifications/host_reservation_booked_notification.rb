# To deliver this notification:
#
# HostReservationBookedNotification.with(reservation: @reservation).deliver_later(current_user)
# HostReservationBookedNotification.with(reservation : @reservation).deliver(current_user)

class HostReservationBookedNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  deliver_by :email, mailer: "ReservationMailer", method: :host_booked
  deliver_by :webpush, class: "DeliveryMethods::Webpush"
  
  # deliver_by :twilio
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :reservation
  param :message



  # Define helper methods to make rendering easier.
  #
  def message
    "#{params[:reservation]} has booked your reservation"
  end



  after_deliver do
    Rails.logger.info "HostReservationBookedNotification delivered to #{recipient.email}"
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end
