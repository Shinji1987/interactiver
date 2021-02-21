class ShopsController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @shop = Shop.find_by(user_id: @user.id)
    @shop.update(shop_update_params)
    redirect_to user_path
  end

  private

  def shop_update_params
    params.permit(:shop_image, :shop_name, :shop_category_id, :shop_description, :shop_address).merge(user_id: @user.id)
  end
end
