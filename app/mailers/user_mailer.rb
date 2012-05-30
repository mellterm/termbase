class UserMailer < ActionMailer::Base
  default   :from => "administrator@example.com",
            :bcc => "mellterm@gmail.com",
            :reply_to => "mellterm@gmail.com"
        
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    #allows access in template
    @user = user
    @url = edit_password_reset_url(@user.password_reset_token)
    mail(:to => @user.email, :from => "mellterm@gmail.com")
  end
end
