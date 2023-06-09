class UserMailer < ApplicationMailer
  default from: 'mathieu@dwish.fr'

  def welcome_email(user)
    @user = user
    @url = 'https://dwish.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Bienvenue chez Dwish !')
  end

  def confirm_order_email(user, order)
    @user = user
    @order = order
    @url = "https://dwish.herokuapp.com/orders/#{order.id}"

    mail(to: @user.email, subject: 'Confirmation de votre commande')
  end
end
