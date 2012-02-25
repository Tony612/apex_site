class Notifier < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.forgot_password.subject
  #
  def forgot_password
    @greeting = "Hi"

    mail :to => "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.activate.subject
  #
  def activate(user)
    @user = user
    @url = "http://apex-studio.herokuapp.com/activate?code=#{user.activation_code}"
#   @recipients = user.email
#   @from = "hbing@7th-chapter.com"
#   @subject = "Please activate your new account"

    mail to: user.email, subject: 'Please activate your new account'
#  :template_path => 'notifier',
#        :template_name => 'activate')
  end

end
