class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item
  before_action :set_cart

  def index
    @cart = Cart.find(session[:cart_id])
    @cart_items = CartItems.all
  end

  def new
    @cart_item = CartItem.new
  end

  def show
  end

  def edit
  end

  def count
    @cart_size = CartItem.where(cart_id: session[:cart_id]).count
  end

  def create
    begin
      @cart = Cart.find_by(session[:cart_id])
      puts "cart found"
    rescue ActiveRecord::RecordNotFound => e
      puts "Cart not found"
      e.record.errors.full_messages
      render json: { message: 'error' }
      return
    end

    begin
      @item = Item.find(params[:item_id])
      puts "item found"
    rescue ActiveRecord::RecordNotFound => e
      puts "Item not found"
      e.record.errors.full_messages
      render json: { message: 'error' }
      return
    end
    begin
      @cart_item = CartItem.create(cart_id: @cart.id, item_id: @item.id, price: @item.price, name: @item.name)
    rescue ActiveRecord::RecordNotFound => e
      puts "Cart item not found"
      e.record.errors.full_messages
      render json: { message: 'error' }
    return
    end

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
      @cart = Cart.find(session[:cart_id])
      @item = Item.find(params[:item_id])
      @cart_item=CartItem.where(cart_id: @cart,item_id: @item).last
      puts "@cart_item.id: #{@cart_item.id}"
      @cart_item.delete
  
      respond_to do |format|
        format.html { redirect_to cart_path(@cart), notice: "Article #{@item.name} supprimé du panier." }
        format.json { head :no_content }
      end
    end


  private
  
  def set_cart_item
    @cart_item = CartItem.find_by(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:cart_id, :item_id, :quantity, :price)
  end

end