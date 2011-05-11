class HomeController < ApplicationController
	
	def public
	end

	def index
		@user = current_user
		if @user
			@user_statuses = @user.statuses
			@date_range = []
			(1..20).each do |days_back|
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
		redirect_to :action => "public" if current_user.nil?
	end

	def about
	end

end
