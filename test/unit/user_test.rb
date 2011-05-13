require 'test_helper'

class UserTest < ActiveSupport::TestCase
	should_validate_presence_of :name, :email
	should_validate_uniqueness_of :email
end
