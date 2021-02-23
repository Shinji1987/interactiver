class SecuritysController < ApplicationController
  before_action :authenticate_user!

  def new
    if User.search(params[:keyword]) != nil
      if request.referer&.include?("/securitys") && User.search(params[:keyword]).count != User.all.count
          @users = User.search(params[:keyword])
      end
    end
    @block_users = Security.where(block_user_id: current_user.id)
  end

  def create
    @user = User.find(params[:format])
    @security = Security.new(security_params)
    @security.save
    redirect_back(fallback_location: new_security_path)
  end

  def destroy
    @user = User.find(params[:id])
    @security = Security.find_by(block_user_id: current_user.id, blocked_user_id: @user.id)
    @security.destroy
    redirect_back(fallback_location: new_security_path)
  end

  private

  def security_params
    params.permit().merge(block_user_id: current_user.id, blocked_user_id: @user.id)
  end
end