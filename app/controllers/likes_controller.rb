class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @like = @post.likes.new(user: current_user)

    if @like.save
      respond_to do |format|
        format.html { redirect_to @post, notice: 'You liked this post.' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: 'Unable to like post.' }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@post) }
      end
    end
  end

  def destroy
    @like = @post.likes.find_by(user: current_user)
    @like.destroy if @like

    respond_to do |format|
      format.html { redirect_to @post, notice: 'You unliked this post.' }
      format.turbo_stream
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end


