class StatusesController < ApplicationController
	before_filter :authorize
	# GET /statuses
	# GET /statuses.xml
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

		respond_to do |format|
			format.html # index.html.erb
			format.xml	{ render :xml => @user_statuses }
		end
	end

	def calendar
		@user = current_user
		@user_statuses = @user.statuses

		respond_to do |format|
			format.html # index.html.erb
			format.xml	{ render :xml => @user_statuses }
		end
	end

	# GET /statuses/1
	# GET /statuses/1.xml
	def show
		@user = User.find current_user.id
		@user_status = Status.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml	{ render :xml => @user_status }
		end
	end

	# GET /statuses/new
	# GET /statuses/new.xml
	def new
		@user = User.find current_user.id
		@user_status = Status.new :user => @user
		if params[:date]
			@user_status.for_date = params[:date]
		end

		respond_to do |format|
			format.html # new.html.erb
			format.xml	{ render :xml => @status }
		end
	end

	# GET /statuses/1/edit
	def edit
		@user = User.find current_user.id
		@user_status = Status.find(params[:id])
	end

	# POST /statuses
	# POST /statuses.xml
	def create
		@user = current_user
		params[:status][:user_id] = @user.id
		@user_status = Status.new(params[:status])

		respond_to do |format|
			if @user_status.save
				format.html { redirect_to(user_statuses_path, :notice => 'Status was successfully created.') }
				format.xml	{ render :xml => @user_status, :status => :created, :location => @user_status }
			else
				format.html { render :action => "new" }
				format.xml	{ render :xml => @user_status.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /statuses/1
	# PUT /statuses/1.xml
	def update
		@user = current_user
		params[:status][:user_id] = @user.id
		@user_status = Status.find(params[:id])

		respond_to do |format|
			if @user_status.update_attributes(params[:status])
				format.html { redirect_to(@user_status, :notice => 'Status was successfully updated.') }
				format.xml	{ head :ok }
			else
				format.html { render :action => "edit" }
				format.xml	{ render :xml => @user_status.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /statuses/1
	# DELETE /statuses/1.xml
	def destroy
		@user_status = Status.find(params[:id])
		if @user_status.user == current_user
			@user_status.destroy
		end

		respond_to do |format|
			format.html { redirect_to(user_statuses_url) }
			format.xml	{ head :ok }
		end
	end
end
