class RemindersController
	def self.send_daily_reminder(for_date=1.day.ago.to_date)
		User.find(:all).each do |user|
			Reminders.daily(user, for_date).deliver unless user.status_logged_for_today?(for_date)
		end
	end
	
end