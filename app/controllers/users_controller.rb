class UsersController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user
  after_action :welcome_email, only: [:create]

  include PaygreenService

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if (current_user.id == @user.id) 
    @orders = Order.where(user_id: @user.id)
    else 
      redirect_to action: "show", id: current_user.id 
    end
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

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
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

  def invalid_user
    logger.error "Attempt to access invalid user #{params[:id]}"
    redirect_to action: "show", id: current_user.id 
  end

end
