class CartsController < ApplicationController
  helper_method :display_name
  helper_method :generate_cart_total_amount
  
    def index
      @carts = Cart.all
    end

    def show
      @cart = Cart.find_by_id(params[:id])
      
      
    end

    def create
      @cart = Cart.new(user_id: @current_user.id, status: 0)
      puts "user_id: #{ @current_user.id}"
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
 

def display_name(id)
  Item.find_by_id(id.to_i).name
end 

 private   

 def generate_cart_total_amount
  content=@cart.cart_items
  total_amount=0
  content.each do |an_item| 
  total_amount=total_amount+( an_item.price*an_item.quantity)
  end
  puts "total_amount: #{total_amount} € #{@cart.id}" 
  total_amount
end



end