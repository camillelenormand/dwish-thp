class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  include PaygreenService

  def create
    @user = current_user
    @cart = Cart.find(params[:cart_id])

    # Create payment order
    new_payment_order = PaygreenService.create_payment_order(@cart.amount, @user.first_name, @user.last_name, @user.email)
    
    # Check if payment order was created
    if new_payment_order[:hosted_payment_url] && new_payment_order[:payment_order_id]
      # Update cart with payment order id
      @cart.update(payment_order_id: new_payment_order[:payment_order_id], status: "pending")
      # Redirect to payment page
      redirect_to new_payment_order[:hosted_payment_url], notice: "Vous allez être redirigé vers la page de paiement"
    else
      redirect_to cart_path(@cart), alert: "Une erreur est survenue, veuillez réessayer."
    end

  end

  def success
    # Check payment status
    @cart = Cart.find(params[:cart_id])
    payment_order_id = @cart.payment_order_id
    token = PaygreenService.authenticate
    payment_order = PaygreenService.get_payment_order(payment_order_id, token)
    
    if payment_order[:transaction_status] = 'transaction.successed'
      @cart.update(status: "paid")
      redirect_to checkout_success_path, notice: "Votre commande a bien été validée" ## TO DO: redirigé vers la page de confirmation de commande

  end

  def cancel
    if payment_order[:transaction_status] = 'transaction.canceled'
      @cart.update(status: "canceled")
      redirect_to checkout_cancel_path, alert: "Le paiement a été annulé"
    else
      redirect_to checkout_error_path, alert: "Une erreur est survenue, veuillez réessayer."
    end

  end

  def expired
    if payment_order[:transaction_status] = 'transaction.expired'
      @cart.update(status: "expired")
      redirect_to checkout_error_path, alert: "Le paiement a expiré"
    else
      redirect_to checkout_error_path, alert: "Une erreur est survenue, veuillez réessayer."
    end

  end

  private

  def checkout_params
    params.require(:checkout).permit(:cart_id, :payment_order_id, :status)
  end

end
