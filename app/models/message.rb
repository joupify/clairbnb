class Message < ApplicationRecord
  belongs_to :from_user, class_name: 'User'  ## we do not need to sepcify foreign key because it is default "from_user"
  belongs_to :to_user, class_name: 'User'
  belongs_to :reservation, optional: true

  after_create_commit :notify_to_user

  def notify_to_user
    NewMessage.with(message: self).deliver_later(to_user)
  end
end
