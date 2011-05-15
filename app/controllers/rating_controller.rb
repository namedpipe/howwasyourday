class RatingController < ApplicationController
  def rate
		link = RatingLink.find_by_link_hash params[:id]
		if link
			@rating = link.user.statuses.create(:for_date => link.for_date, :rating => link.rating)
		end
		redirect_to(home_index_path, :notice => 'Status was successfully created.')
  end

end
