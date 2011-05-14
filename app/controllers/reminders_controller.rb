class RemindersController
	def self.send_daily_reminder(time_for=1.day.ago.to_date)
		User.find(:all).each do |user|
			Reminder.deliver_daily(user, for_date) unless user.status_logged_for_today?(time_for)
		end
	end
	
end