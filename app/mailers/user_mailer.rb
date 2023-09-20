class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    return unless @user.email

    mail(to: @user.email, subject: 'Welcome to My Swiggy App')
  end

  def forgot_password_token
    @user = params[:user]
    return unless @user.email

    mail(to: @user.email, subject: 'Forgot Password Token')
  end
end
