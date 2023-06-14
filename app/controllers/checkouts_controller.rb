class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  include PaygreenService

  def create(total_price, first_name, last_name, email)
    # Create payment order
    response = PaygreenService.create_payment_order(total_price, first_name, last_name, email)
    # Check if payment order was created
    if response[:hosted_payment_url] && response[:payment_order_id]
      # Update cart with payment order id
      @cart.update(payment_order_id: response[:payment_order_id], status: "pending")
      # Redirect to payment page
      redirect_to response[:hosted_payment_url], notice: "Vous allez être redirigé vers la page de paiement"
    else
      redirect_to root_path, alert: "Une erreur est survenue"
    end

  end

  def success
    # Get payment order id from params
    payment_order_id = params[:payment_order_id]
    token = PaygreenService.authenticate
    payment_order = PaygreenService.get_payment_order(payment_order_id, token)
    
    if payment_order["status"] == 200 && payment_order["status"] == "paid"
      @cart.update(status: "paid")
      redirect_to root_path, notice: "Votre commande a bien été validée"
    else
      @cart.update(status: "cancelled")
      redirect_to root_path, alert: "Le paiement a échoué"
    end
  end

  def cancel
    @cart.update(status: "cancelled")
    redirect_to root_path, alert: "Votre commande a été annulée"
  end

  private

  def checkout_params
    params.require(:checkout).permit(:cart_id, :payment_order_id, :status)
  end

end
