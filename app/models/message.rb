class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :from_user, class_name: "User"
  belongs_to :to_user, class_name: "User"

  scope :unread, -> { where(is_read: false) }

  after_commit :broadcast_message

  def broadcast_message
    broadcast_append_to(
      [ :conversations, self.conversation_id ],
      target: [ self.from_user, :messages ],
      partial: "messages/message",
      locals: { message: self, current_user: self.from_user }
    )

    broadcast_append_to(
      [ :conversations, self.conversation_id ],
      target: [ self.to_user, :messages ],
      partial: "messages/message",
      locals: { message: self, current_user: self.to_user }
    )
  end
end
