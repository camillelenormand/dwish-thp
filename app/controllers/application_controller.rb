class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordInvalid, with: :show_errors  
  protect_from_forgery with: :exception
  include ApplicationHelper
  before_action :initialize_cart 

  add_flash_types :info, :error, :warning, :success
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation, :current_password)}
  end

end
