class Reminders < ActionMailer::Base
	default_url_options[:host] = HowWasYourDay::Application.config.host_for_emails
  default :from => "reminders@howwasyourday.namedpipe.net"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminders.daily.subject
  #
  def daily(user, for_date)
		@user = user
		@missing_date = for_date
		mail :to => user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminders.weekly.subject
  #
  def weekly(user, for_date)
    @greeting = "Hi"

    mail :to => user.email
  end
end
