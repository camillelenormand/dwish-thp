class UserMailer < ApplicationMailer
  default from: 'no-reply@dwish.fr'

  def welcome_email(user)
    @user = user

    @url = 'https://dwish-staging.herokuapp.com/users/sign_in'

    mail(to: @user.email, subject: 'Bienvenue chez Dwish !')
  end

end
