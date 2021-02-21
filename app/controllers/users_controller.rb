class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @friend_request_from = FriendRequest.where(to_user_id: current_user).pluck(:from_user_id)
    @friend_requests = FriendRequest.where(to_user_id: current_user, requesting_status: 1)
    @request_count = @friend_requests.count
    @friend_lists = FriendRequest.where("from_user_id = ? or to_user_id = ?", current_user.id, current_user.id).where(requesting_status: 2).pluck(:from_user_id, :to_user_id)
    @friend_list_others = FriendRequest.where("from_user_id = ? or to_user_id = ?", @user.id, @user.id).where(requesting_status: 2).pluck(:from_user_id, :to_user_id)
    if user_signed_in?
      if current_user.id == @user.id
        @friend_request = FriendRequest.find_by(to_user_id: current_user)
        # これは、空である場合にわかればいいから、find_byでいい。
        @friend_request_status = FriendRequest.where(to_user_id: current_user).pluck(:requesting_status)
      else
        @friend_request = FriendRequest.find_by(from_user_id: current_user.id, to_user_id: @user.id)
        @friend_requested = FriendRequest.find_by(from_user_id: @user.id, to_user_id: current_user.id)
        if @friend_request == nil
          @friend_request = FriendRequest.find_by(from_user_id: @user.id, to_user_id: current_user.id)
        end
      end
    end
    @footprint = Footprint.new(footprint_params)
    if @footprint.visitor_user_id != @footprint.visited_user_id
      @footprint.save
    end
    @shop = Shop.find_by(user_id: @user)
    if @shop == nil
      @shop = Shop.new(shop_params)
      @shop.save
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  def search
    @users = User.search(params[:keyword])
  end

  private

  def user_params
    params.require(:user).permit(:image, :nickname, :family_name_kanji, :first_name_kanji, :family_name_kana, :first_name_kana, :birthday, :profile)
  end

  def footprint_params
    params.permit().merge(visitor_user_id: current_user.id, visited_user_id: @user.id)
  end

  def shop_params
    params.permit().merge(shop_name: "", shop_category_id: 1, shop_description: "", shop_address: "", user_id: @user.id)
  end
end