class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone, :username, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone, :username, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login])
  end

  def authenticate!
    unless user_signed_in?
      session[:previous_url] = request.fullpath
      flash[:alert] = "You need to sign in or sign up before continuing."

      respond_to do |format|
        format.js { render :js => "window.location = '#{new_user_session_path}'" }
      end
    end
  end
end
