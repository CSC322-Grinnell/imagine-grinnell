require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end
  
  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: "tester@test.com", password: "password", password_confirmation: "password" } }
    end
    assert_response :success
  end
  
  test "should get index" do
    get users_url
    assert_response :success
  end
  
  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end
  end
  
  test "should show user" do
    get user_url(@user)
    assert_response :success
  end
  
end