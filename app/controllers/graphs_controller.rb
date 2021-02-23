class GraphsController < ApplicationController
  def index
    @user_posts = Post.where(user_id: current_user.id)
  end
end
