module ApplicationHelper

  def navbar_cart_id
    @cart = Cart.find_by(user_id: current_user.id, status: "in_progress")
    return @cart.id
  end

  def cart_size
    @cart_items = CartItem.where(cart_id: navbar_cart_id)
    total = @cart_items.sum(:quantity)
    return total
  end

end



