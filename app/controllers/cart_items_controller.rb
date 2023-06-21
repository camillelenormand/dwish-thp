class CartItemsController < ApplicationController

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
        format.html { redirect_to cart_path(@cart) , notice: "Article #{@item.name} ajouté au panier" }
        #format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        #format.json { render json: cart.errors, status: :unprocessable_entity }
      end
    end 
  end

end