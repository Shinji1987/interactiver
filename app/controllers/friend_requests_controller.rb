class FriendRequestsController < ApplicationController
  before_action :find_user, only: [:index, :create, :destroy, :reject, :remove]
  before_action :findby_user, only: [:reject, :remove]

  
  def index
    @friend_lists = FriendRequest.where("from_user_id = ? or to_user_id = ?", current_user.id, current_user.id).where(requesting_status: 2).pluck(:from_user_id, :to_user_id)
    @friend_list_others = FriendRequest.where("from_user_id = ? or to_user_id = ?", @user.id, @user.id).where(requesting_status: 2).pluck(:from_user_id, :to_user_id)
  end

  def create
    @friend_request = FriendRequest.new(friend_request_params)
    @friend_request.save
  end

  def destroy
    @friend_request = FriendRequest.find_by(from_user_id: current_user.id, to_user_id: @user.id)
    @friend_request.destroy
  end

  def reject
    if @friend_request != nil
      @friend_request.destroy
      redirect_to edit_user_friend_request_path
    else
      render 'posts/index'
    end
  end

  def remove
    if @friend_request != nil
      @friend_request.destroy
      redirect_to user_path(@user.id)
    elsif FriendRequest.find_by(to_user_id: @user.id, from_user_id: current_user)
      @friend_request = FriendRequest.find_by(to_user_id: @user.id, from_user_id: current_user)
      @friend_request.destroy
      redirect_to user_path(@user.id)
    else
      render 'posts/index'
    end
  end

  def edit
    @friend_request = FriendRequest.where(to_user_id: current_user).pluck(:from_user_id)
    if @friend_request == []
      redirect_to user_path
    else
      @user = User.find(params[:user_id])
      @from_user = FriendRequest.where(to_user_id: current_user).pluck(:from_user_id)
      @users =  User.where(id: @from_user)
      @friend_request_status = FriendRequest.where(to_user_id: current_user).pluck(:requesting_status)
      @friend_request = FriendRequest.find_by(from_user_id: current_user)
      unless @friend_request_status.include?(1)
        redirect_to user_path
      end
    end
  end

  def update
    @from_user = User.find(params[:user_id])
    @friend_request = FriendRequest.where(to_user_id: current_user, from_user_id: @from_user.id)
    @friend_request.update(friend_requested_params)
    redirect_to edit_user_friend_request_path
  end

  private

  def friend_request_params
    params.permit().merge(from_user_id: current_user.id, to_user_id: @user.id, requesting_status: 1)
  end

  def friend_requested_params
    params.permit(:from_user_id, :to_user_id).merge(requesting_status: 2)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def findby_user
    @friend_request = FriendRequest.find_by(to_user_id: current_user, from_user_id: @user.id)
  end
end