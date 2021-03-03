class LikesController < ApplicationController
  before_action :find_post, :only => [:create, :destroy]
  before_action :where_like, :only => [:create, :destroy]
  before_action :authenticate_user!

  def create
    like = current_user.likes.build(:post_id => params[:post_id])
    like.save
  end

  def destroy
    like = Like.find_by(:post_id => params[:post_id], :user_id => current_user.id)
    like.destroy
  end

  private

  def find_post
    # binding.pry
    @post = Post.find(params[:post_id])
  end

  def where_like
    likes = Like.where(:post_id => @post.id)
  end
end