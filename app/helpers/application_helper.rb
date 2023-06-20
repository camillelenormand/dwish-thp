module ApplicationHelper

  # def set_cart
  #   begin
  #     @cart = Cart.find_by(user_id: current_user&.id, status: 'in_progress')
  #     puts "cart found, id: #{@cart}, user_id: #{current_user&.id}, status: 'in_progress'"
  #   rescue ActiveRecord::RecordNotFound
  #     puts "cart not found"
  #   end

  #   begin
  #     @cart = Cart.find(session[:cart_id])
  #     puts "cart found, id: #{session[:cart_id]}"
  #   rescue ActiveRecord::RecordNotFound
  #     @cart = Cart.create(user_id: current_user&.id, status: 'in_progress', id: session[:cart_id])
  #     puts "cart created, id: #{@cart.id}, user_id: #{current_user&.id}, status: 'in_progress'"
  #     session[:cart_id] = @cart.id
  #     puts "cart id stored in session, id: #{session[:cart_id]}"
  #   end

  # end

  def cart_count_over_one
    total_cart_items ? total_cart_items : 0
  end

  def total_cart_items
    @cart.cart_items.map(&:quantity).sum if @cart
  end


  def navbar_cart_path
    @cart = Cart.find_by(session[:cart_id])
      if @cart.present? 
        my_cart_path=cart_path(@cart&.id)
      else
        my_cart_path=items_path
      end
      my_cart_path  
  end


  def initialize_cart
    puts "current_user :#{current_user}"
    puts "user_id: #{ @current_user.id}"
    @cart ||= Cart.find_by(id: session[:cart_id])
    puts "cart: #{@cart}"
  
   if @cart.nil?
     @cart = Cart.create(user_id: @current_user.id, status: 0)
     puts "cart: #{@cart}"
     session[:cart_id] = @cart.id
     puts "session: #{session[:cart_id]}"
   end
  end

end
