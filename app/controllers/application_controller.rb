class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller? 
  before_action :set_var

  protected

    def configure_permitted_parameters
    # sign_upのときに、nameをストロングパラメータに追加する
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
    # account_updateのときに、nameをストロングパラメータに追加する
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email])
    end
    
    def set_var
      @dw = ["日", "月", "火", "水", "木", "金", "土"]
      @ki = ["none","s1","s2","A","B","C","日曜特訓"]
    end
end
