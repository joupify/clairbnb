class MessageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.new_message.subject
  #
  def new_message
    @message = params[:message]

    mail(to: @message.to_user.email, from: @message.from_user.email, subject: "You have a new message from #{@message.from_user.email}")

  end
end
