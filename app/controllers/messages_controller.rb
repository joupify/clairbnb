class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation

  def index
    @reservation = set_reservation
    if @reservation
      @messages = @reservation.messages.includes(:from_user)
      @message = @reservation.messages.new
    else
      flash[:alert] = "Reservation not found."
      redirect_to reservations_path
    end
  end

  def create
    if @reservation
      @message = current_user.sent_messages.new(message_params)
      @message.to_user = @reservation.guest == current_user ? @reservation.host : @reservation.guest
      @message.from_user = current_user
    
      if @message.save
        flash.now[:notice] = "Message sent successfully"
      else
        # Display validation errors (if any)
        flash[:alert] = @message.errors.full_messages
      end
    
      # Reload messages associated with the reservation
      @messages = @reservation.messages.includes(:from_user)
    else
      flash[:alert] = "Reservation not found."
      redirect_to reservations_path
    end
  end

  def set_reservation
    @reservation = current_user.reservations.find_by(id: params[:reservation_id])
    @reservation ||= current_user.host_reservations.find_by(id: params[:reservation_id])
  end
  

  def message_params
    params.require(:message).permit(:content, :reservation_id)
  end
end
