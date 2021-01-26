class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if user_signed_in?
      @friend_request = FriendRequest.find_by(from_user_id: current_user.id, to_user_id: @user.id)
    end
    # @friend_request = FriendRequest.find(params[:id])
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

  private

  def user_params
    params.require(:user).permit(:image, :nickname, :family_name_kanji, :first_name_kanji, :family_name_kana, :first_name_kana, :birthday, :profile)
  end
end
