class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Message ko render karna (HTML format mein)
    html = ApplicationController.render(
      partial: 'messages/message', 
      locals: { message: message }
    )

    # Broadcast the rendered HTML to the chatroom
    ActionCable.server.broadcast "chatroom_channel_#{message.chatroom_id}", { html: html }
  end
end
