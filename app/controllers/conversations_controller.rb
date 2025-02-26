class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations
  end
  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.order(:created_at)
    @message = Message.new
  end
end
