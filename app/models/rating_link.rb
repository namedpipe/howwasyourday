class RatingLink < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :for_date, :rating, :user_id, :link_hash
	validates_uniqueness_of :link_hash
	validates_uniqueness_of :user_id, :scope => [:for_date, :rating]
	before_validation(:on => :create) do
		self.link_hash = Digest::SHA1.hexdigest("#{user.email}--#{for_date}--#{rating}")
	end
	
end
	
