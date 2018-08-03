class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailer.user.subject_activation")
  end

  def password_reset user
    @user = user
    @greeting = t "mailer.user.greeting"
    mail to: user.email, subject: t("mailer.user.subject_reset")
  end
end
