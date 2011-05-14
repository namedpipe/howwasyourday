class User < ActiveRecord::Base
	include Clearance::User
	has_many :statuses, :order => "for_date DESC"
	validates_uniqueness_of :email
	validates_presence_of :email
	validates_presence_of :name
	before_save   :initialize_salt, :encrypt_password
	before_create :generate_remember_token
	
	def status_logged_for_today?(date=Time.now.to_date)
		statuses.count(:all, :conditions => ["for_date = ?", date]) > 0
	end
	
	def current_good_streak
		if (statuses.count(:all, :conditions => ["for_date = ? AND rating = 'Good'", 1.day.ago.to_date]) > 0)
			tally = 1
			statuses.find(:all, :conditions => ["for_date < ? AND rating = 'Good'", 1.day.ago.to_date]).each do |good_status|
				if good_status.for_date == (1.day.ago.to_date - tally)
					tally += 1
				else
					break
				end
			end
			tally
		else
			0
		end
	end

	def longest_good_streak
		statuses.count
	end
	
	def good_rating_link_for(date=Time.now.to_date)
		# salt date 
		"/rating/"
	end

	def mixed_rating_link_for(date=Time.now.to_date)
		""
	end

	def bad_rating_link_for(date=Time.now.to_date)
		""
	end
	
	def message_after_login_or_fresh_visit
		message = ""
		message << "You haven't rated yesterday yet. You should do that now." unless status_logged_for_today?(1.day.ago.to_date)
		message << "You've got a nice streak of <strong>#{current_good_streak}</strong> good days going. Good job!" if (current_good_streak > 3)
		message
	end

end
