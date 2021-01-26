class PostsController < ApplicationController
  def index
    @posts = Post.all.order('created_at DESC')
    @post = Post.new
    @like = Like.create
    # @user = User.find(params[:user_id])
    # @friend_request = FriendRequest.find_by(from_user_id: current_user.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render("posts/new")
    end
  end

  private

  def post_params
    params.require(:post).permit(:text, :post_image).merge(user_id: current_user.id)
  end
end
