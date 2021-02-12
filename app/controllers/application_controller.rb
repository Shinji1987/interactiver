class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :configre_permitted_parameters, if: :devise_controller?

  def configre_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:image, :nickname, :family_name_kanji, :first_name_kanji, :family_name_kana, :first_name_kana, :birthday, :profile, :shop_address])
  end
end
