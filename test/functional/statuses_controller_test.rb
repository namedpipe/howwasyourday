require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:one)
		current_user = User.find :first
		@user = current_user
  end

  test "should get index" do
    get :index, :user_id => @user.id
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "should get new" do
    get :new, :user_id => @user.id
    assert_response :success
  end

  test "should create status" do
    assert_difference('Status.count') do
      post :create, :status => @status.attributes
    end

    assert_redirected_to status_path(assigns(:status))
  end

  test "should show status" do
    get :show, :id => @status.to_param, :user_id => @user.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @status.to_param, :user_id => @user.id
    assert_response :success
  end

  test "should update status" do
    put :update, :id => @status.to_param, :status => @status.attributes
    assert_redirected_to user_status_path(assigns(:status))
  end

  test "should destroy status" do
    assert_difference('Status.count', -1) do
      delete :destroy, :id => @status.to_param
    end

    assert_redirected_to user_statuses_path
  end
end
