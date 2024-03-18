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
    case event.type
    when "checkout.session.completed"
      #do something with checkout  session and reservation
      checkout_session = event.data.object
      reservation = Reservation.find_by(session_id: checkout_session.id)
      if reservation.nil?
         raise "No Reservation Found with Checkout Session ID: #{checkout_session.d}"
      end
      reservation.update(status: :booked, stripe_payment_intent_id: checkout_session.payment_intent)

      puts "Checkout Session ID: #{checkout_session.id}"
      puts "Checkout Session Metadata: #{checkout_session.metadata}"

    end
  end

end