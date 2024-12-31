class CommentsController < ApplicationController
  before_action :authenticate_user! 

  def create
    @post = Post.find(params[:post_id]) 
    @comment = @post.comments.create(comment_params) 

    # Automatically set user_id from the current user
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: 'Your comment was successfully posted.'
    else
      redirect_to @post, alert: 'Comment cannot be empty.'
    end
  end


  def destroy
    @post = Post.find(params[:post_id]) 
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to @post, notice: 'Your comment was successfully destroyed'
    
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
