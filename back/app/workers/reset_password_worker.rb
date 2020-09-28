class ResetPasswordWorker < MailerWorker
  def perform user_id
    user = user.find user_id
    user_info = {user_id: user_id, mail_to: user.email}
    send_mailer ResetPasswordMailer.reset_password_email(user), receiver_info: user_info
  end
end
