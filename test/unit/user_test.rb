require 'test_helper'

class UserTest < ActiveSupport::TestCase
	should_validate_presence_of :name, :email, :password
	should_validate_uniqueness_of :email

	test "a new user should send a welcome note" do
		u = User.new :name => "Mike", :email => "testing@hwd.com", :password => "testing"
		assert u.save
	end
end
