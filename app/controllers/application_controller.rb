class ApplicationController < ActionController::Base
  protect_from_forgery :with => :null_session
  before_action :configre_permitted_parameters, :if => :devise_controller?
  before_action :mylogger_test
  before_action :basic_auth
  

  def configre_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, :keys => [:image, :nickname, :family_name_kanji, :first_name_kanji, :family_name_kana, :first_name_kana, :birthday, :profile])
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

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTHENTICATE_USER"] && password == ENV["BASIC_AUTHENTICATE_PASSWORD"]
    end
  end
end
