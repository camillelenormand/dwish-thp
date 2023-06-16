class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_cart
  def index
    @CartItems = CartItems.all
  end

  def new
  end

  def show
 
  end

  def count
    @cart_size = CartItem.where(cart_id: session[:cart_id]).count
  end



  def create
    p params
    puts params[:item_id].to_i
    @item = Item.find(params[:item_id].to_i)
    quantity=1
    
    puts "cart_id: #{ session[:cart_id]}"
    puts "item_id: #{ @item.id}"
    puts "quantity: #{quantity}"
    puts "price: #{@item.price}"

    
    @CartItem = CartItem.new(cart_id: session[:cart_id], item_id: @item.id, quantity: 1, price: @item.price )


    respond_to do |format|
      if @CartItem.save
        format.html { redirect_to items_path , notice: "Article #{@item.name} ajouté au panier" }
        #format.json { render :show, status: :created, location: @item }
        else
        format.html { render :new, status: :unprocessable_entity }
      #format.json { render json: cart.errors, status: :unprocessable_entity }
      end
    end 
  end


  def initialize_cart
    puts "initialize carte"
    puts "current_user :#{current_user}"
    puts "user_id: #{ @current_user.id}"
    
    @cart ||= Cart.find_by(id: session[:cart_id])
    
  
   if @cart.nil?
     @cart = Cart.create(user_id: @current_user.id, status: 0)
     puts "cart: #{@cart}"
     session[:cart_id] = @cart.id
     puts "session: #{session[:cart_id]}"
   end 
  end




end