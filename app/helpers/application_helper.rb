module ApplicationHelper

  def navbar_cart_id
   @cart=Cart.find_by(user_id: current_user.id)
   puts "@cart=Cart.find_by(user_id: current_user.id) =#{Cart.find_by(user_id: current_user.id)}"
   @cart.id if @cart.present?
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