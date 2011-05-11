class Status < ActiveRecord::Base
	VALID_RATING_OPTIONS = ["Good", "Mixed", "Bad"]
	belongs_to :user
	validates_presence_of :rating
	validates_inclusion_of :rating, :in => VALID_RATING_OPTIONS
	validates_uniqueness_of :for_date, :scope => "user_id"
	
	
	def date
		for_date
	end
	
	def display_status
		if comments.to_s != ""
			rating + " on " + for_date.to_s + " - " + comments
		else
			rating + " on " + for_date.to_s
		end
	end
	
end
