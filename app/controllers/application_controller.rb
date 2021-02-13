class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :configre_permitted_parameters, if: :devise_controller?
  before_action :mylogger_test

  def configre_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:image, :nickname, :family_name_kanji, :first_name_kanji, :family_name_kana, :first_name_kana, :birthday, :profile, :shop_address])
  end


  class MyLogger < Logger
    include LoggerSilence
    include ActiveSupport::LoggerThreadSafeLevel
    include ActiveSupport::LoggerSilence
  end

  private

  def mylogger_test
    mylogger = MyLogger.new(STDOUT)
    mylogger.silence do
      mylogger.debug("controller = #{controller_name}")
      mylogger.info("action = #{action_name}")
      mylogger.error("controler#action = #{controller_name}##{action_name}")
    end
  end
end
# test
