class LikeChannel < ApplicationCable::Channel
  def subscribed
    # Stream from a specific post using its post_id
    stream_for params[:post_id]
  end

  def unsubscribed
    # Any cleanup needed when the channel is unsubscribed
  end
end
