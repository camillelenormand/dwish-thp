class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_email(params[:email])
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone)
  end

end
