class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    puts "-------- webhook received ---------"
    order = Order.find_by(payment_order_id: params.dig(:id))
    puts "order found: #{order.id}, status: #{order.status}, cart: #{order.cart_id}"

    if params.dig(:status) == 'payment_order.successed'
      
    begin
      order.update!(status: "paid")
      puts "------ order updated --- status: #{order.status}"
    rescue ActiveRecord::RecordInvalid => e
      puts e.record.errors.full_messages
      render json: { message: 'error' }
      return
    end

    # Find existing cart
    begin
      cart = Cart.find(order.cart_id)
    rescue ActiveRecord::RecordNotFound => e
      puts "Cart not found"
      puts e.record.errors.full_messages
      render json: { message: 'error' }
      return
    end

    # update cart 
    begin
      cart.update!(status: "paid")
      puts "Cart updated --- status: #{cart.status}"
      session[:cart_id] = [] # empty session
      puts "Cart session destroyed --- session: #{session[:cart_id]}"
      puts "Session: #{session}"
    rescue ActiveRecord::RecordInvalid => e
      puts "Cart not updated"
      puts e.record.errors.full_messages
      render json: { message: 'error' }
      return
    end

    # Send confirmation email
    send_confirmation_email

      render json: { message: 'success' }

    elsif params.dig(:status) == 'payment_order.failed'

      render json: { message: 'failed' }

    else
      render json: { message: 'error' }
    end

  end

  private

  def send_confirmation_email
    order = Order.find_by(payment_order_id: params.dig(:id))
    user = User.find(order.user_id)
    UserMailer.confirm_order_email(user, order).deliver_now
    puts "Confirmation email sent"
  end

end
