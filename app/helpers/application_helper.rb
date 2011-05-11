module ApplicationHelper
	
	def date_format(pub_date)
		if pub_date.nil? or pub_date==0
			return '...'
		else
			# standard date format, remove leading zeros from day-of-month numbers
			pub_date.strftime("%A, %B %d, %Y").gsub(/\ 0(\d),/, ' \1,')
		end
	end
end
