class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :create, :new]

  include PaygreenService

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
    new_buyer = PaygreenService.create_buyer(params[:first_name], params[:last_name], params[:email], params[:phone_number], params[:user_id])
    if new_buyer[:buyer_id]
      render json: { buyer_id: new_buyer[:buyer_id] }
    else
      render json: { message: 'error' }
    end
    
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

  def create_buyer
     new_buyer = PaygreenService.create_buyer(params[:first_name], params[:last_name], params[:email], params[:phone_number], params[:user_id])
     if new_buyer[:buyer_id]
       render json: { buyer_id: new_buyer[:buyer_id] }
     else
       render json: { message: 'error' }
     end
  end


  private

  def user_params
    params.require(:user).permit(
      :email, 
      :first_name, 
      :last_name, 
      :phone,
      :password,
      :password_confirmation,
    )
  end



end
