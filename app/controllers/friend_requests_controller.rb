class FriendRequestsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @friend_lists = FriendRequest.where("from_user_id = ? or to_user_id = ?", current_user.id, current_user.id).where(requesting_status: 2).pluck(:from_user_id, :to_user_id)
    @friend_list_others = FriendRequest.where("from_user_id = ? or to_user_id = ?", @user.id, @user.id).where(requesting_status: 2).pluck(:from_user_id, :to_user_id)
  end

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
    # current_userが2で@userが8

    @friend_request.destroy
  end

  def reject
    @user = User.find(params[:user_id])

    @friend_request = FriendRequest.find_by(to_user_id: current_user, from_user_id: @user.id)

    if @friend_request != nil
      # @friend_request.destroy

      # redirect_to user_path(current_user.id)
      # redirect_to edit_user_friend_request_path(@user.id)

      
      # @from_user = FriendRequest.where(to_user_id: current_user).pluck(:from_user_id)
      # @users = User.where(id: @from_user)
      # @friend_request_status = FriendRequest.where(to_user_id: current_user).pluck(:requesting_status)
      # @friend_request = FriendRequest.find_by(from_user_id: current_user)
      # unless @friend_request_status.include?(1)
      #   redirect_to user_path(current_user.id)
      # end
    @friend_request.destroy
    redirect_to edit_user_friend_request_path
    else
      render 'posts/index'
    end
  end

  def remove
    @user = User.find(params[:user_id])
    @friend_request = FriendRequest.find_by(to_user_id: current_user, from_user_id: @user.id)
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
      # binding.pry
      # @friend_requests = FriendRequest.where(to_user_id: current_user)
      # @friend_requests = @friend_requests.includes(:user)
      @user = User.find(params[:user_id])
      # @users = User.all
      @from_user = FriendRequest.where(to_user_id: current_user).pluck(:from_user_id)
      @users =  User.where(id: @from_user)
      @friend_request_status = FriendRequest.where(to_user_id: current_user).pluck(:requesting_status)
      # current_userが2の場合、@userの中身は、7。

      # @friend_request = FriendRequest.where(from_user_id: current_user).pluck(:to_user_id)
      # @friend_request = FriendRequest.find_by(to_user_id: current_user)
      @friend_request = FriendRequest.find_by(from_user_id: current_user)
      
      # @from_user = FriendRequest.where(from_user_id: current_user).pluck(:from_user_id)
      # binding.pry
      unless @friend_request_status.include?(1)
        redirect_to user_path
      end
      # binding.pry
      # @friend_request = FriendRequest.find(params[:user_id])
      # @user = User.find(params[:user_id])
      # @friend_request = FriendRequest.find_by(from_user_id: @user.id)
    end
  end

  def update
    # binding.pry
    @from_user = User.find(params[:user_id])
    @to_user = User.find(params[:id])
    # @friend_request = FriendRequest.find(params[:id])

    # @friend_request = FriendRequest.where(from_user_id: current_user).pluck(:to_user_id)
    # if FriendRequest.find_by(from_user_id: current_user.id, to_user_id: @user.id)
    
    @friend_request = FriendRequest.where(to_user_id: current_user, from_user_id: @from_user.id)
    # @friend_request.requesting_status = 2
    # binding.pry
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
end