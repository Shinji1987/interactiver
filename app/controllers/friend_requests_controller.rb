class FriendRequestsController < ApplicationController
  def index
    @friend_requests = FriendRequest.all
    @friend_requests = @friend_requests.includes(:user)
    # binding.pry
    # @friend_request = FriendRequest.find(params[:user_id])
    @user = User.find(params[:user_id])
    @friend_request = FriendRequest.find_by(from_user_id: @user.id)
  end
    
  # def new
  #   # @friend_requests = FriendRequest.all
  #   # @friend_requests = @friend_requests.includes(:user)
  #   # # binding.pry
  #   # # @friend_request = FriendRequest.find(params[:user_id])
  #   # @user = User.find(params[:user_id])
  #   # @friend_request = FriendRequest.find_by(from_user_id: @user.id)
  # end

  def create
    @user = User.find(params[:user_id])
    @friend_request = FriendRequest.new(friend_request_params)
    # @friend_request = current_user.friend_requests.build
    # @friend_request.requesting_status = 1    #ステータス1は友達申請中
    # @friend_request.from_user_id = current_user.id
    # @friend_request.to_user_id = @user.id
    @friend_request.save
  end

  def destroy
    @user = User.find(params[:user_id])
    @friend_request = FriendRequest.find_by(from_user_id: current_user.id, to_user_id: @user.id)
    @friend_request.destroy
  end

  private

  def friend_request_params
    params.permit().merge(from_user_id: current_user.id, to_user_id: @user.id, requesting_status: 1)
  end
end