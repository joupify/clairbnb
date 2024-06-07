class Message < ApplicationRecord
  belongs_to :from_user, class_name: 'User'  ## we do not need to sepcify foreign key because it is default "from_user"
  belongs_to :to_user, class_name: 'User'
  belongs_to :reservation, optional: true
  has_noticed_notifications
  # after_create_commit :broadcast_message


  after_create_commit -> { broadcast_append_to "messages" }
  after_update_commit { broadcast_replace_to "messages" }
  after_destroy_commit -> { broadcast_remove_to "messages" }

  broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend





  after_create_commit :notify_to_user


  def self.mark_as_read!
    all.map(&:notifications_as_message).flatten.each(&:mark_as_read!)
  end



  def notify_to_user
    NewMessage.with(message: self).deliver_later(to_user)
  end

  private

  # def broadcast_message
  #   broadcast_append_to(
  #     "messages",
  #     target: "messages",
  #     partial: "messages/message",
  #     locals: { message: self }
  #   )
  # end

end



  