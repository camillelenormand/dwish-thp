module ApplicationHelper

  def navbar_cart_id
    @cart = Cart.find_by(user_id: current_user.id)
    @cart.id if @cart.present?
  end

  def cart_size
    @cart_items = CartItem.where(cart_id: @cart).count || 0
    session[:cart_size] = @cart_items
    @cart_items
  end

end
