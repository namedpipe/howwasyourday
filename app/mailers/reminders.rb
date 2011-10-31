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
		mail :to => user.email, :subject => "Reminder - How was #{for_date.strftime('%A, %B %d')}?"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminders.weekly.subject
  #
  def weekly(user, for_date)
    @user = user
    if @user
      earliest = @user.statuses.minimum("for_date")
      days_since_start = (Time.now.to_date - earliest).to_i + 1
      if days_since_start > 7
        @num_days = 7
      else
        @num_days = days_since_start
      end
      @user_statuses = @user.statuses
      @date_range = []
      (1..@num_days).each do |days_back|
        date_to_look_at = days_back.days.ago.to_date
        found_match = false
        @user_statuses.each do |user_status|
          if user_status.for_date == date_to_look_at
            @date_range.push [days_back.days.ago.to_date, user_status]
            found_match = true
          end
        end
        @date_range.push([days_back.days.ago.to_date, "blank"]) unless found_match
      end
    end

    mail :to => user.email
  end
end
