class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def edit
    @user = current_user
  end

  def create
    
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to root_path, notice: "Votre profil a bien été mis à jour." }
      else
        format.html { render :edit, alert: "Votre profil n'a pas pu être mis à jour. Merci de réessayer." }
      end
    end
  end


  private

  def user_params
    params.require(:user).permit(
      :email, 
      :first_name, 
      :last_name, 
      :phone)
  end



end
