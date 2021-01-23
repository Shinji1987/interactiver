class LikesController < ApplicationController
  def create
    like = Like.create(like_params)
  end

  private

  def like_params
    params.permit().merge(user_id: current_user.id, post_id: params[:post_id])
  end
end