class User < ActiveRecord::Base
	include Clearance::User
	has_many :statuses, :order => "for_date DESC"
	validates_uniqueness_of :email
	validates_presence_of :email
	validates_presence_of :name
	before_save   :initialize_salt, :encrypt_password
	before_create :generate_remember_token
	
	def status_logged_for_today?(date=Time.now.to_date)
		statuses.find(:first, :conditions => ["on_date = ?", date]) > 0
	end
	
	def current_good_streak
		statuses.count
	end

	def longest_good_streak
		statuses.count
	end
	
	def good_rating_link_for(date=Time.now.to_date)
		""
	end

	def mixed_rating_link_for(date=Time.now.to_date)
		""
	end

	def bad_rating_link_for(date=Time.now.to_date)
		""
	end

end
