class ResetPasswordMailer < ApplicationMailer
  default from: "example@gmail.com"
  layout "mailer"

  def reset_password_email user
    @user = user
    @auth_token = JsonWebToken.encode({user_id: user.id, email: user.email})
    mail to: @user.email, subject: I18n.t("message_mails.reset_password.subject")
  end
end
