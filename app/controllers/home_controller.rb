class HomeController < ApplicationController
	
	def public
	end

	def index
		@user = current_user
		if @user
			earliest = @user.statuses.minimum("for_date")
			if earliest
				days_since_start = (Time.now.to_date - earliest).to_i + 1
			end
			
			if days_since_start.nil?
				@num_days = 5
			elsif days_since_start > 28
				@num_days = 28
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
			fresh_message = @user.message_after_login_or_fresh_visit
			if fresh_message != "" && flash[:notice].nil?
				flash[:notice] = fresh_message
			end
		end
		redirect_to :action => "public" if current_user.nil?
	end

	def about
	end

end
