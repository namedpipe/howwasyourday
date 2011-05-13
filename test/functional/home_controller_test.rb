require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get public" do
    get :public
    assert_response :success
  end

  test "should get index" do
		current_user = User.find :first
    get :index
    assert_response :success
  end

end
