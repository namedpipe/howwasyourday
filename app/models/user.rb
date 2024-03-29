require 'digest/sha1'

class User < ActiveRecord::Base
	include Clearance::User
	has_many :statuses, :order => "for_date DESC"
	has_many :rating_links
	validates_uniqueness_of :email
	validates_presence_of :email
	validates_presence_of :name
	before_save   :initialize_salt, :encrypt_password
	before_create :generate_remember_token
	after_create :send_welcome_notification
	
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
			if tally > longest_good_streak
				write_attribute :longest_good_streak, tally
				save
			end
			tally
		else
			0
		end
	end

	def set_longest_good_streak
		streak = 0
		longest_streak = 0
		statuses.each do |status|
			if status.rating == 'Good'
				streak += 1
				if streak > longest_streak
					longest_streak = streak
				end
			else
				streak = 0
			end
		end
		write_attribute :longest_good_streak, longest_streak
		save
		longest_streak
	end
	
	def good_rating_link_for(date=Time.now.to_date)
		rating_link_for date, "Good"
	end

	def mixed_rating_link_for(date=Time.now.to_date)
		rating_link_for date, "Mixed"
	end

	def bad_rating_link_for(date=Time.now.to_date)
		rating_link_for date, "Bad"
	end
	
	def rating_link_for(date, rating_type)
		existing_link = rating_links.find(:first, :conditions => ["rating = ? AND for_date = ?", rating_type, date])
		if existing_link
			rating_link = existing_link
		else
			rating_link = rating_links.create(:for_date => date, :rating => rating_type)
		end
		"/rate/#{rating_link.link_hash}"
	end
	
	def message_after_login_or_fresh_visit
		message = ""
		message << "You haven't rated yesterday yet. You should do that now." unless status_logged_for_today?(1.day.ago.to_date)
		message << "You've got a nice streak of <strong>#{current_good_streak}</strong> good days going. Good job!" if (current_good_streak > 3)
		message << "Awesome job! You're on your longest good streak of <strong>#{longest_good_streak}</strong>" if (current_good_streak == longest_good_streak)
		message
	end

	private
	def send_welcome_notification
		Notifications.welcome(self).deliver
	end

end
