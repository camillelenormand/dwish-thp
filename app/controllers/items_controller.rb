class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action :initialize_cart
  helper_method :generate_cart_total_amount

  # GET /items or /items.json
  def index
    @categories = Category.all
    @items = Item.all
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy!

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
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
   

    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.fetch(:item, {})
    end
   

    def initialize_cart
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





