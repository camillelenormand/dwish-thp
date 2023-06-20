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
    @cart=Cart.find_by(user_id: current_user.id)
    
    pp @cart
    puts "@cart=Cart.find_by(user_id: current_user.id)  #{@cart}  user_id: current_user.id #{current_user.id} "
    puts "@cart.id: #{@cart&.id} " 
    
      if @cart.present? 
        puts "#cart.present? #{@cart.present? }"
        my_cart_path=cart_path(@cart&.id)
      else
        my_cart_path=items_path
      end
      my_cart_path  
  
  end

end
