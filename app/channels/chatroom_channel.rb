class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom_channel_#{params[:chatroom_id]}" #(strean_from for user revicve mgs in real time)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
