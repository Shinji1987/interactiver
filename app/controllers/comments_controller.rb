class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comments = Comment.all
    @comments = @comments.includes(:user)
    @comment = Comment.new
    @post = Post.find(params[:post_id])   
  end
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.valid?
       @comment.save
       redirect_to new_post_comment_path
    else
      redirect_to new_post_comment_path, :flash => {:notice => "コメントを入力してください"}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(:user_id => current_user.id, :post_id => params[:post_id])
  end
end