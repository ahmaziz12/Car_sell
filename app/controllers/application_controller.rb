class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

  private
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone, :username, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone, :username, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login])
  end
end
