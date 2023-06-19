class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  include PaygreenService

  def create

    begin 
      @cart = Cart.find_by(session[:cart_id])
      puts "Cart found #{@cart.id}"
    rescue ActiveRecord::RecordNotFound => e
      puts "Cart not found"
      render json: { message: 'error' }
      return
    end

    begin 
      @cart_items = @cart.cart_items
      puts "Cart items found"
    rescue ActiveRecord::RecordNotFound => e
      puts "Cart items not found"
      render json: { message: 'error' }
      return
    end

    begin
      @user = current_user
      puts "User found #{@user.id}"
    rescue ActiveRecord::RecordNotFound => e
      puts "User not found"
      render json: { message: 'error' }
      return
    end

    begin
      @order = Order.create!(user_id: current_user.id, status: "draft", amount: @cart.total_amount, payment_order_id: nil, cart_id: @cart.id)
      puts "order created, order id: #{@order.id}, order amount: #{@order.amount}}, status: #{@order.status}}"
    rescue ActiveRecord::RecordInvalid => e
      puts e.record.errors.full_messages
      render json: { message: 'error' }
      return
    end
    
    new_payment_order = PaygreenService.create_payment_order(@cart.total_amount.to_i, @user.first_name, @user.last_name, @user.email, @user.phone, @user.id)
    
    # Check if payment order was created
    if new_payment_order[:hosted_payment_url] && new_payment_order[:payment_order_id]
      puts "payment order created"
      begin
        @order.update!(payment_order_id: new_payment_order[:payment_order_id])
        puts "order updated with payment order id"
      rescue ActiveRecord::RecordInvalid => e
        puts e.record.errors.full_messages
        render json: { message: 'error' }
        return
      end
        
      redirect_to new_payment_order[:hosted_payment_url], allow_other_host: true
    else
      redirect_to cart_path(@cart), alert: "Une erreur est survenue, veuillez réessayer."
    end

  end

  def success
    po_id = params[:po_id]
    status = params[:status]
    @order = Order.find_by(payment_order_id: po_id)
  end

  def cancel
    @cart.update(status: "cancelled")
    redirect_to checkouts_cancel_path, alert: "Le paiement a été annulé"
  end

  private

  def checkout_params
    params.require(:checkout).permit(:cart_id, :payment_order_id, :status, :po_id)
  end

end
