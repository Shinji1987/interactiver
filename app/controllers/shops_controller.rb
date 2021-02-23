class ShopsController < ApplicationController
  def edit
    @user = User.find(params[:id])
    @shop = Shop.find_by(user_id: @user.id)
  end

  def update
    @shop = Shop.find_by(user_id: current_user.id)
    @shop.update(shop_update_params)
    redirect_to user_path(current_user.id)
  end

  private

  def shop_update_params
    params.require(:shop).permit(:shop_image, :shop_name, :shop_category_id, :shop_description, :shop_address).merge(user_id: current_user.id)
  end
end
