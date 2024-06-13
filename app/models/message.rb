# == Schema Information
#
# Table name: messages
#
#  id             :bigint           not null, primary key
#  from_user_id   :bigint           not null
#  to_user_id     :bigint           not null
#  reservation_id :bigint           not null
#  content        :text             default(""), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Message < ApplicationRecord
  belongs_to :from_user, class_name: 'User', foreign_key: "from_user_id"  ## we do not need to sepcify foreign key here because it is default "from_user"
  belongs_to :to_user, class_name: 'User', foreign_key: "to_user_id"
  belongs_to :reservation, optional: true
  has_noticed_notifications

  # # Alternatively, using the synchronous methods directly
  # after_create_commit -> { broadcast_prepend_to "messages" }
  # after_update_commit -> { broadcast_replace_to "messages" }
  # after_destroy_commit -> { broadcast_remove_to "messages" }

  # after_create_commit { broadcast_prepend_later_to "messages" }
  # after_update_commit { broadcast_replace_later_to "messages" }
  # after_destroy_commit { broadcast_remove "messages" }


  # broadcasts_to ->(message) { "reservation_#{message.reservation_id}_messages" }, inserts_by: :prepend
  broadcasts_to ->(message) { [message.reservation, "messages"] }, inserts_by: :prepend

  after_create_commit :notify_to_user


  def notify_to_user
    NewMessage.with(message: self).deliver_later(to_user)
  end

  def self.mark_as_read!
    all.map(&:notifications_as_message).flatten.each(&:mark_as_read!)
  end

  private


end



  
