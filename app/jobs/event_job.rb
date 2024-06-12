class EventJob < ApplicationJob
  queue_as :default

  def perform(event)
    case event.source
    when "stripe"
      stripe_event = Stripe::Event.construct_from(JSON.parse(event.request_body, symbolize_names: true))
      begin
        handle_stripe(stripe_event)
        event.update(
          event_type: stripe_event.type,
          error_message: "",
          status: :processed
        )
      rescue => e
        event.update(
          error_message: e.message,
          status: :failed
        )
      end
    else
      event.update(
        error_message: "unknown source #{event.source}",
        status: :failed
      )
    end
  end
  

  def handle_stripe(event)
    puts "Handling stripe event: #{event.type}"

    case event.type

    when "account.updated"
    puts "Handling account.updated event"
    account = event.data.object
    puts "Event data: #{event.inspect}"

    user = User.find_by(stripe_account_id: account.id)
    if user.nil?
      puts "User not found for stripe_account_id: #{account.id}"
    else
      puts "Updating charges_enabled for user: #{user.id}"
      user.update(charges_enabled: account.charges_enabled)
      puts "charges_enabled updated: #{user.charges_enabled}"
    end


    when "checkout.session.completed"
      #do something with checkout  session and reservation
      checkout_session = event.data.object
      reservation = Reservation.find_by(session_id: checkout_session.id)
      if reservation.nil?
         raise "No Reservation Found with Checkout Session ID: #{checkout_session.d}"
      end
      reservation.update(status: :booked, stripe_payment_intent_id: checkout_session.payment_intent)
      HostReservationBookedNotification.with(reservation: reservation, message: "New Booking! #{reservation.guest.email} is coming #{reservation.start_date}").deliver_later(reservation.host)
      GuestReservationBookedNotification.with(reservation: reservation).deliver_later(reservation.guest)

    when "checkout.session.expired"
      checkout_session = event.data.object
      reservation = Reservation.find_by(session_id: checkout_session.id)
      if reservation.nil?
        raise "No Reservation Found with Checkout Session ID: #{checkout_session.d}"
     end
     reservation.update(status: :expired)

    when "identity_verification_session_verified"
      session = event.data.object
      user = User.find_by(id: session .metadata.user_id)
      if user.nil?
         raise "No User found with this  ID: #{session.metadata.user_id}"
      end
     if session.status == "verified"  
      user.update(identity_verified: :true)
     else
      user.update(identity_verified: :false)
     end


    when "charge.refunded"
      #do something with checkout  session and reservation
      charge = event.data.object
      reservation = Reservation.find_by(stripe_payment_intent_id: charge.payment_intent)
      if reservation.nil?
         raise "No Reservation Found with Payment Intent  ID: #{charge.payment_intent}"
      end
      reservation.update(status: :cancelled)

      puts "Checkout Session ID: #{checkout_session.id}"
      puts "Checkout Session Metadata: #{checkout_session.metadata}"

    end
  end

end 