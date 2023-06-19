class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item
  before_action :set_cart

  def index
    begin 
    @cart = Cart.find(session[:cart_id])
    puts "cart found, id: #{session[:cart_id]}"
    rescue ActiveRecord::RecordNotFound => e
      e.record.errors.full_messages
      render json: { message: 'error' }
      return
    end

    begin 
    @cart_items = CartItems.all
    puts "cart items found"
    rescue ActiveRecord::RecordNotFound => e
      e.record.errors.full_messages
      render json: { message: 'error' }
      return
    end

  end

  def new
    @cart_item = CartItem.new
  end

  def count
    begin
    @cart_size = CartItem.where(cart_id: session[:cart_id]).count
    puts "cart size found, size: #{@cart_size}"
    rescue ActiveRecord::RecordNotFound => e
      puts "Cart size not calculated"
      render json: { message: 'error' }
      return
    end
  end

  def create
    begin
      @cart = Cart.find(session[:cart_id])
      puts "cart found, id: #{session[:cart_id]}"
  
      @item = Item.find(params[:item_id])
      puts "item found, id: #{params[:item_id]}"
  
      @cart_item = CartItem.create(cart_id: @cart.id, item_id: @item.id, price: @item.price, name: @item.name, quantity: 1)
      puts "cart item created, id: #{params[:item_id]}, cart_id: #{session[:cart_id]},  price: #{params[:price]}, name: #{params[:name]}, quantity: #{params[:quantity]}"
  
        if @cart_item.save && URI(request.referer).path == items_path
          redirect_to items_path , notice: "Article #{@item.name} ajouté au panier." 
        elsif @cart_item.save && URI(request.referer).path == cart_path(@cart)
          redirect_to cart_path(@cart) , notice: "Article ajouté au panier."
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @cart_item.errors, status: :unprocessable_entity }
        end

    rescue ActiveRecord::RecordNotFound => e
      puts "#{e.record.class} not found"
      e.record.errors.full_messages
      render json: { message: 'error' }
      return
    end
  end
  

    # DELETE /cart_items/1 or /items/1.json
    def destroy
      @cart_item = CartItem.where(cart_id: @cart).find_by(item_id: params[:item_id])
      @cart_item.destroy
  
      respond_to do |format|
        format.html { redirect_to cart_path(@cart), notice: "Article supprimé du panier." }
        format.json { head :no_content }
      end
    end


  private

  def set_cart
    @cart = Cart.find_by(session[:cart_id])
    puts "cart found, id: #{session[:cart_id]}"
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: 'error' }
  end
  
  def set_cart_item
    @cart_item = CartItem.where(cart_id: @cart)
  end

  def cart_item_params
    params.require(:cart_item).permit(:cart_id, :item_id, :quantity, :price)
  end
end