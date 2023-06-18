module CheckoutsHelper

  def get_cart
    @cart = Cart.find_by(user_id: current_user.id, status: "in_progress")
  end
  
end
