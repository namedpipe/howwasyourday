class Reminders < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminders.daily.subject
  #
  def daily
    @greeting = "Hi"

    mail :to => "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminders.weekly.subject
  #
  def weekly
    @greeting = "Hi"

    mail :to => "to@example.org"
  end
end
