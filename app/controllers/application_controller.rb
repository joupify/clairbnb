class ApplicationController < ActionController::Base
    before_action :authenticate_user!

  def current_user
  current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


    private

  def current_reservation
    @current_reservation ||= current_user.reservations if user_signed_in?
  end
  helper_method :current_reservation
end
