module CartsHelper
  def generate_cart_total_amount
    @total_amount = @cart.cart_items.sum { | item | item.price * item.quantity }
    return @total_amount
  end

  def display_name(id)
    Item.find_by(id: id)&.name
  end 


end
