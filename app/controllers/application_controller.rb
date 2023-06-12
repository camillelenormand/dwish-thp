class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning, :success

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :lastname, :email, :password)}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :phone, :current_password)}
  end

end
