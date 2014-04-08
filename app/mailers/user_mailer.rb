class UserMailer < ActionMailer::Base
  default from: "no-reply@swe.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.email_confirmation.subject
  #
  def email_confirmation(user)
    @user = user

    mail to: user.email , subject: 'Welcome to Subjects Complaint System'
  end
end
