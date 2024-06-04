# To deliver this notification:
#
# GuestReservationBookedNotification.with(post: @post).deliver_later(current_user)
# GuestReservationBookedNotification.with(post: @post).deliver(current_user)

class GuestReservationBookedNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  deliver_by :email, mailer: "ReservationMailer", method: :guest_booked
  # deliver_by :webpush, class: "DeliveryMethods::Webpush"

  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :reservation

  # Define helper methods to make rendering easier.
  #
 
  def message
    "Reservation ##{params[:reservation].id} has been booked"
  end


  after_deliver do
    Rails.logger.info "GuestReservationBookedNotification delivered to #{recipient.email}"
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end
