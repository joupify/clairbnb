class Message < ApplicationRecord
  belongs_to :from_user, class_name: 'User'  ## we do not need to sepcify foreign key because it is default "from_user"
  belongs_to :to_user, class_name: 'User'
  belongs_to :reservation, optional: true
end
