class ApplicationController < ActionController::Base
    before_action :authenticate_user!



    private

  def current_reservation
    @current_reservation ||= current_user.reservations if user_signed_in?
  end
  helper_method :current_reservation
end
