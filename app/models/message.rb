class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :from_user, class_name: "User"
  belongs_to :to_user, class_name: "User"

  scope :unread, -> { where(is_read: false) }

end
