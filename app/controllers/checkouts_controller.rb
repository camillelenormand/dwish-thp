class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  include PaygreenService

  def new

  end

  def create
    @cart = Cart.where(user_id: current_user.id, status: "in_progress").last
    @user = current_user
    @cart_items = CartItem.where(cart_id: @cart.id)
    
    new_payment_order = PaygreenService.create_payment_order(@cart.total_amount.to_i, @user.first_name, @user.last_name, @user.email)
    
    if new_payment_order[:hosted_payment_url] && new_payment_order[:payment_order_id]
      redirect_to new_payment_order[:hosted_payment_url], allow_other_host: true
    else
      redirect_to checkout_error_path, alert: "An error occurred, please try again."
    end
  end

  def success
    @cart = Cart.find(params[:cart_id])
    payment_order_id = @cart.payment_order_id
    token = PaygreenService.authenticate
    payment_order = PaygreenService.get_payment_order(payment_order_id, token)
    
    if payment_order[:transaction_status] == 'transaction.successed'
      @cart.destroy!
      redirect_to root_path, notice: "Your order has been successfully confirmed."
      @order = Order.create!(user_id: current_user.id, status: "paid", total_amount: payment_order[:amount], payment_order_id: payment_order_id)
    end
  end

  def cancel
    payment_order = PaygreenService.get_payment_order(@cart.payment_order_id, PaygreenService.authenticate)
    if payment_order[:transaction_status] == 'transaction.canceled'
      @cart.update(status: "canceled")
      redirect_to checkout_cancel_path, alert: "The payment has been canceled"
    else
      redirect_to checkout_error_path, alert: "An error occurred, please try again."
    end
  end

end
