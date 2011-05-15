class RatingLink < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :for_date, :rating, :user_id
	before_create :setup_link_hash
	
	private
	def setup_link_hash
		self.link_hash = Digest::SHA1.hexdigest("#{user.email}--#{for_date}--#{rating}")
	end
end
	
