module ApplicationHelper

  def set_cart
    @cart = Cart.find(session[:cart_id])
    puts "cart found, id: #{session[:cart_id]}"
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create(user_id: current_user&.id, status: 'in_progress', total_amount: 0)
    puts "cart created, id: #{session[:cart_id]}, user_id: #{current_user&.id}, status: 'in_progress', total_amount: 0"
    session[:cart_id] = @cart.id
    puts "cart id stored in session"
  end

  def cart_count_over_one
    return total_cart_items if total_cart_items > 0
  end

  def total_cart_items
    total = @cart.cart_items.map(&:quantity).sum
  end

end
