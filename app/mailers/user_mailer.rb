class UserMailer < ApplicationMailer
  default from: 'camille.lenormand02@gmail.com'

  def welcome_email(user)
    @user = user
    @url = 'https://dwish-staging.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Bienvenue chez Dwish !')
  end

  def confirm_order_email(user, order)
    @user = user
    @order = order
    @url = "https://dwish-staging.herokuapp.com/orders/#{order.id}"

    mail(to: @user.email, subject: 'Confirmation de votre commande')
  end
end
