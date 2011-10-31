class Notifications < ActionMailer::Base
  default_url_options[:host] = HowWasYourDay::Application.config.host_for_emails
  default :from => "reminders@howwasyourday.namedpipe.net"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.welcome.subject
  #
  def welcome(user)
    @greeting = "Hi"
    @user = user

    mail :to => user.email, :subject => "Welcome to 'How Was Your Day?'"
  end
end
