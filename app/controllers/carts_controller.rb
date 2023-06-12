class CartsController < ApplicationController

    def index
      @carts = Cart.all
    end

    def create
      @carts = Cart.new(user_id: @current_user.id, status: 0)
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
 


end
