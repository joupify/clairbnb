class DeliveryMethods::Webpush < Noticed::DeliveryMethods::Base
  def deliver
    # Use the message from the notification
    notification_message = notification.message
    return if notification_message.nil? || (notification_message.respond_to?(:empty?) && notification_message.empty?)

    case notification
    
    when HostReservationBookedNotification
      recipient.webpush_subs.each do |sub|
        sub.publish("Reservation: #{notification_message}")
      end
    when GuestReservationBookedNotification
      recipient.webpush_subs.each do |sub|
        sub.publish("Reservation: #{notification_message}")
      end
    when NewMessage
      recipient.webpush_subs.each do |sub|
        sub.publish("Message: #{notification_message}")
        puts "Message: #{notification_message}"
      end
    else
      recipient.webpush_subs.each do |sub|
        sub.publish(notification_message)
      end
    end
  end
end
