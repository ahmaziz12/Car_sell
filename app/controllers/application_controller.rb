class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone, :username, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone, :username, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login])
  end

end
