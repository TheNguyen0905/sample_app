class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailer.user.subject")
  end

  def password_reset
    @greeting = t "mailer.user.greeting"
    mail to: Settings.mail_to
  end
end
