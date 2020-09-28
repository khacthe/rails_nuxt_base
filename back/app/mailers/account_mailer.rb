class UserMailer < ApplicationMailer
  default from: "example@gmail.com"
  layout "mailer"

  def register_user_email user
    @user = user
    @auth_token = JsonWebToken.encode({user_id: user.id, email: user.email})
    mail to: @user.email, subject: I18n.t("message_mails.register_user.subject")
  end
end
