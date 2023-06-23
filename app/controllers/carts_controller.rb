class CartsController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  before_action :initialize_cart, only: [:show, :update, :destroy]
  
    def index
      @carts = Cart.all
    end

  def show
    @cart = Cart.find(session[:cart_id])
    #test to validate cart is the last one created and belongs to the user
    # if not ,redirected to items_path
    if (current_user.id == @cart.user_id) && (@cart.id == Cart.where(user_id: current_user.id ).last.id)
       @cart_items = @cart.cart_items
       else
        redirect_to items_path, notice: "Désolé, accès non autorisé."
    end    
  end

  def create
    @cart = Cart.new(user_id: @current_user.id, status: "in_progress")
    
    respond_to do |format|
      if @cart.save
        format.html { redirect_to item_url(@cart), notice: "Cart was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @cart = Cart.find(params[:id])
    
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: cart.errors, status: :unprocessable_entity }
      end
    end

  end
  
  def destroy
    @cart.destroy!

    respond_to do |format|
      format.html { redirect_to items_path, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
private

def initialize_cart
@cart = Cart.find(params[:id]) 
end

def invalid_cart
  logger.error "Attempt to access invalid cart #{params[:id]}"
  redirect_to root_path, notice: "Désolé, panier inexistant."
  
end

def cart_params
  params.require(:cart).permit(:user_id, :status)
end

end
