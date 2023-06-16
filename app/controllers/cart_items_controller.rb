class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_cart
  
  def index
    @cart = Cart.find(session[:cart_id])
    @cart_items = CartItems.all
  end

  def new
  end

  def show
 
  end

  def count
    @cart_size = CartItem.where(cart_id: session[:cart_id]).count
  end

  def create
    @cart = Cart.find(session[:cart_id])
    @item = Item.find(params[:item_id])
    @cart_item = CartItem.new(cart_id: @cart.id, item_id: @item.id, quantity: 1, price: @item.price, name: @item.name )

    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to cart_path(@cart) , notice: "Article #{@item.name} ajouté au panier." }
        #format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        #format.json { render json: cart.errors, status: :unprocessable_entity }
      end
    end 
  end

    # DELETE /cart_items/1 or /items/1.json
    def destroy
      puts "test destroy"
      @cart = Cart.find(session[:cart_id])
      @item = Item.find(params[:item_id])
      @cart_item=CartItem.where(cart_id: @cart,item_id: @item).last
      puts "objet @cart_item:  CartItem.where(cart_id: 1,item_id: 1).last"
      pp @cart_item
      puts "@cart_item.id: #{@cart_item.id}"
      @cart_item.delete
  
      respond_to do |format|
        format.html { redirect_to cart_path(@cart), notice: "Article #{@item.name} supprimé du panier." }
        format.json { head :no_content }
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