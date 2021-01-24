class LikesController < ApplicationController
  # before_action :post_params
  
  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.build(post_id: params[:post_id])
    like.save
    likes = Like.where(post_id: @post.id)
    # like = Like.create(like_params)
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    like.destroy
    likes = Like.where(post_id: @post.id)
  end

  private

  def like_params
    params.permit().merge(user_id: current_user.id, post_id: params[:post_id])
  end

  # def post_params
  #   @post = Post.find(params[:post_id])
  # end
end