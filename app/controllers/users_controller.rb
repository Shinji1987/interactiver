class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    # unless User.exists?(id: current_user.id)
    #   redirect_to edit_user_path
    # end
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
