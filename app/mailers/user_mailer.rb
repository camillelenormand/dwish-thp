class UserMailer < ApplicationMailer
  default from: 'no-reply@dwish.fr'

  def welcome_email(user)
    @user = user

    @url = 'https://dwish-staging.herokuapp.com/users/sign_in'

    mail(to: @user.email, subject: 'Bienvenue chez Dwish !')
  end

  def confirm_order_email(user)
    user_id = @user.id
    @order = Order.where(user_id: user_id).last

    url = f"https://dwish-staging.herokuapp.com/users/#{user_id}"
    return url

    mail(to: @user.email, subject: 'Confirmation de votre commande')
  end

end
