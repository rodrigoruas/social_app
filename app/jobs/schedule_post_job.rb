class SchedulePostJob < ApplicationJob
  queue_as :default

  def perform(user_id, content)
    # schedule the post to be created
    user = User.find(user_id)
    post = Post.create(user: user, content: content)
  end
end
