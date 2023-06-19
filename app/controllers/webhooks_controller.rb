class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    puts "-------- webhook received ---------"
    order = Order.find_by(payment_order_id: params.dig(:id))
    puts "-------- order found: #{order}, order id: #{order.id} ---------"

    if params.dig(:status) == 'payment_order.successed'
      
    begin
      order.update!(status: "paid")
      puts "------ order updated --- status: #{order.status}"
    rescue ActiveRecord::RecordInvalid => e
      puts e.record.errors.full_messages
      render json: { message: 'error' }
      return
    end

    # Send confirmation email
    send_confirmation_email

    # delete cart
    begin
      cart = Cart.find(order.cart_id)
    rescue ActiveRecord::RecordNotFound => e
      puts "Cart not found"
      puts e.record.errors.full_messages
      render json: { message: 'error' }
      return
    end

    begin
      cart.destroy!
      # Remove cart from session
      session[:cart_id] = nil
      puts "Cart destroyed"
    rescue ActiveRecord::RecordInvalid => e
      puts "Cart not destroyed"
      puts e.record.errors.full_messages
      render json: { message: 'error' }
      return
    end

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
  end

end
