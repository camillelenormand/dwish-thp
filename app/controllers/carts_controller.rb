class CartsController < ApplicationController
  helper_method :display_name
  helper_method :generate_cart_total_amount
  before_action :set_cart, only: [:show, :create]

  def index
    @carts = Cart.all
  end

  def show
    @user = current_user
  end

  def create
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

  private

  def set_cart
    @cart = Cart.new(user_id: current_user.id, status: "in_progress", total_amount: 0)
  end

  def display_name(id)
    Item.find_by_id(id.to_i).name
  end

  def generate_cart_total_amount
    content = @cart.cart_items
    total_amount = 0
    content.each do |an_item|
      total_amount += an_item.price * an_item.quantity
    end
    puts "total_amount: #{total_amount} € #{@cart.id}"
    total_amount
  end
end
