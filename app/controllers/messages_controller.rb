class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.from_user = current_user
    @message.to_user = @conversation.users.where.not(id: current_user.id).first

    if @message.save
      # redirect_to conversation_path(@message.conversation)
      # render json: {}
      # render turbo_stream: turbo_stream.replace(:new_message, partial: "messages/form", locals: { conversation: @conversation })
      respond_to do |format|
        format.html { redirect_to conversation_path(@message.conversation) }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :conversation_id)
  end
end
