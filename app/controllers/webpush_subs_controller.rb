class WebpushSubsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
    #find the notification , if notif does not exist , create one
    notification = WebpushNotification.find_by(auth_key: params[:keys][:auth])
    if !notification
      notification = WebpushNotification.new(
        user: current_user,  #  add user
        endpoint: params[:endpoint],
        auth_key: params[:keys][:auth],
        p256dh_key: params[:keys][:p256dh],
      )
      end
    if notification.save
      render json: notification, status: :created
    else
      render notification.errors.full_messages, status: :unprocessable_entity
    end
  end

end



