class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all

    if params[:filter_by].present?
      case params[:filter_by]
      when "username"
        @posts = @posts.joins(:user).order("users.username DESC")
      when "username_asc"
        @posts = @posts.joins(:user).order("users.username ASC")
      when "date"
        @posts = @posts.order(created_at: :desc)
      when "date_asc"
        @posts = @posts.order(created_at: :asc)
      when "time"
        @posts = @posts.order(created_at: :asc)
      end
    else
      @posts = @posts.order(created_at: :desc)
    end


    if params[:search].present?
      @posts = @posts.joins(:user).where('users.username ILIKE ?', "%#{params[:search]}%")
      if @posts.empty?
        @posts = Post.search_by_body(params[:search])
      end
    end
  end

  def show
    @posts = Post.all
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  

  private
    def set_post
      @post = Post.find(params[:id])
    end
    def post_params
      params.require(:post).permit(:body, :image)
    end
end





