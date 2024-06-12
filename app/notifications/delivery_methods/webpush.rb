class DeliveryMethods::Webpush < Noticed::DeliveryMethods::Base
  def deliver
    # Use the message from the notification
    notification_message = notification_message_content
    return if notification_message.nil? || (notification_message.respond_to?(:empty?) && notification_message.empty?)

    recipient.webpush_subs.each do |sub|
      sub.publish(notification_message)
    end
  end

  private

  def notification_message_content
    case notification
    when HostReservationBookedNotification
      "Reservation: #{notification.message}"
    when GuestReservationBookedNotification
      "Reservation: #{notification.message}"
    when NewMessage
      "Message: #{notification.message}"
    else
      notification.message
    end
  end
end
