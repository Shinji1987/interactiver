class GraphsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_posts = Post.where(user_id: current_user.id)
  end
end
