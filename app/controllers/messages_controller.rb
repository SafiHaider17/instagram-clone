class MessagesController < ApplicationController
  def create
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


