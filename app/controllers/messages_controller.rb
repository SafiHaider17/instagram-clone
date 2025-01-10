class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :destroy]

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      SendMessageJob.perform_later(@message)
      #redirect_to request.referrer
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      redirect_to @message
    else
      render :edit
    end   
  end

  def destroy
    @message.destroy
    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:content, :chatroom_id, :image)
  end

  def set_message
    @message = Message.find(params[:id])
  end
end



