class MessagesController < ApplicationController
  def create
    #@chatroom = Chatroom.find(params[:chatroom_id])
    #@message = @chatroom.messages.new(message_params)
    #@message.user = current_user
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to request.referrer
       #SendMessageJob.perform_later(@message)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :chatroom_id)
  end
end


