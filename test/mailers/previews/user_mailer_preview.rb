# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def welcome_email
    UserMailer.welcome_email(User.first)
  end

  def confirm_order_email
    @order = Order.first
    UserMailer.confirm_order_email(@order.user)
  end

end
