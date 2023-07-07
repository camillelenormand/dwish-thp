# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include PaygreenService
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    new_user = User.last
    puts "LAST USER : #{new_user}, #{new_user.first_name}, #{new_user.last_name}, #{new_user.email}, #{new_user.phone}, #{new_user.id}"
     # Create user in Paygreen system
    paygreen_user = PaygreenService.create_buyer(
      new_user.first_name,
      new_user.last_name,
      new_user.email,
      new_user.phone,
      new_user.id
    )
    puts "PAYGREEN USER : #{paygreen_user}"
    # Update user with Paygreen ID
    new_user.update(paygreen_id: paygreen_user[:buyer_id])
    puts "PAYGREEN USER ID : #{paygreen_user[:paygreen_id]}"
    puts "DWISH USER PAYGREEN ID : #{new_user.paygreen_id}"
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
