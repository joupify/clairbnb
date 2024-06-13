require 'rails_helper'

RSpec.describe EventJob, type: :job do
  describe '#perform' do
    let(:event) { instance_double('Event', source: 'stripe', request_body: '{"id": "evt_test"}') }
    let(:stripe_event) { double('Stripe::Event', type: 'charge.succeeded') }

    before do
      allow(Stripe::Event).to receive(:construct_from).and_return(stripe_event)
    end

    context 'when the event source is stripe' do
      it 'processes the event successfully' do
        allow(event).to receive(:update)

        expect(Stripe::Event).to receive(:construct_from).with(JSON.parse(event.request_body, symbolize_names: true)).and_return(stripe_event)
        expect(event).to receive(:update).with(
          event_type: stripe_event.type,
          error_message: "",
          status: :processed
        )

        EventJob.perform_now(event)
      end

      before do
        allow(Stripe::Event).to receive(:construct_from).and_raise(StandardError.new('Some error'))
        allow(event).to receive(:update).with(error_message: 'Some error', status: :failed)
      end
  
      it 'handles errors during processing' do
        expect {
          EventJob.perform_now(event)

        }.to raise_error(StandardError, 'Some error')
      end

    end

    context 'when the event source is unknown' do
      let(:event) { instance_double('Event', source: 'unknown', request_body: '{"id": "evt_test"}') }

      it 'fails with an unknown source error' do
        allow(event).to receive(:update)

        expect(event).to receive(:update).with(
          error_message: "unknown source #{event.source}",
          status: :failed
        )

        EventJob.perform_now(event)
      end
    end
  end
end


