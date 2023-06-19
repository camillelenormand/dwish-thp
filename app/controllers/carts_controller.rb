class CartsController < ApplicationController

    def index
      @carts = Cart.all
    end

  def show
    @cart = Cart.find(params[:id])
    @cart_items = @cart.cart_items
    puts "cart_items: #{@cart_items}"
  end

  def create
    @cart = Cart.new(user_id: @current_user.id, status: "in_progress")
    
    respond_to do |format|
      if @cart.save
        format.html { redirect_to item_url(@cart), notice: "Item was successfully created." }
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
      format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
private

def cart_params
  params.require(:cart).permit(:user_id, :status)
end

end
